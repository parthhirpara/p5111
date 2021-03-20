//
//  HttpRequestManager.swift
//  Copyright © 2016 ParthHirpara. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON

//Encoding Type
let URL_ENCODING = URLEncoding.default
let JSON_ENCODING = JSONEncoding.default

//Web Service Result

public enum RESPONSE_STATUS : NSInteger
{
    case INVALID
    case VALID
    case MESSAGE
}
protocol UploadProgressDelegate
{
    func didReceivedProgress(progress:Float)
}

protocol DownloadProgressDelegate
{
    func didReceivedDownloadProgress(progress:Float,filename:String)
    func didFailedDownload(filename:String)
}

class HttpRequestManager
{
    static let sharedInstance = HttpRequestManager()
    let additionalHeader: HTTPHeaders = ["Content-Type": "application/json"]
    var responseObjectDic = Dictionary<String, AnyObject>()
    var URLString : String!
    var Message : String!
    var resObjects:AnyObject!
    var alamoFireManager = Alamofire.Session.default//Alamofire.SessionManager.default
    var delegate : UploadProgressDelegate?
    var downloadDelegate : DownloadProgressDelegate?
    // METHODS
    init()
    {
        alamoFireManager.session.configuration.timeoutIntervalForRequest = 1000 //seconds
        alamoFireManager.session.configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
    }
    
    //MARK:- Cancel Request
    func cancelAllAlamofireRequests(responseData:@escaping ( _ status: Bool?) -> Void)
    {
        alamoFireManager.session.getTasksWithCompletionHandler
            {
                dataTasks, uploadTasks, downloadTasks in
                dataTasks.forEach { $0.cancel() }
                uploadTasks.forEach { $0.cancel() }
                downloadTasks.forEach { $0.cancel() }
                responseData(true)
        }
    }
    
    //MARK:- Delete
    func deleteRequest(service:String,
                    showLoader:Bool,
                    urlParam:String? = "",
                    completionHandler:@escaping (_ responseDict: NSDictionary?, _ error: NSError?) -> Void)
    {
        if isConnectedToNetwork()
        {
            if(showLoader) { showLoaderHUD(strMessage: "") }
            print("Header Param :\(additionalHeader)")
            let escapedString = urlParam?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            print(escapedString!)
            var strURL = "\(BASE_URL)\(service)?\(escapedString ?? "")"
            
            print(strURL)
//            strURL = escapedString ?? ""
            alamoFireManager.request(strURL, method: .delete, parameters:nil , encoding: JSONEncoding.default, headers: additionalHeader)
                .responseJSON { response in
                    hideLoaderHUD()
                    print("Response \(response)")
                    switch(response.result)
                    {
                    case .success(let value):
                        completionHandler(dictionaryOfFilteredBy(dict: (value as? NSDictionary)!), nil)
                        break
                    case .failure(let error):
                        completionHandler(nil,error as NSError?)
                        
                        break
                    }
            }
        }
    }
    
    //MARK:- POST
    
    func requestWithPostMultipartParamWithUploadVideoAndThumb(endpointurl:String,
                                       isImage:Bool,
                                       parameters:NSDictionary,
                                       
                                       showLoader:Bool,
                                       
                                       responseData:@escaping (_ error: NSError?, _ responseDict: NSDictionary?) -> Void)
    {
        if isConnectedToNetwork()
        {
            if showLoader {
                showLoaderHUD(strMessage: "")
            }
            
            print("URL : \(BASE_URL)\(endpointurl)")
            print("param : \(parameters)")
            
            alamoFireManager.upload(multipartFormData: { multipartFormData in

                for (key, value) in parameters
                {
                    
                    if (key as! String) == "File" {

                        let videoData :NSData = try! NSData(contentsOf: value as! URL,options: .mappedIfSafe)
                        multipartFormData.append(videoData as Data, withName: "File", fileName: "File.mp4", mimeType: "mp4")
                    }
                    
                    if (key as! String) == "Thumb" {
                        let imgData = (value as! UIImage).jpegData(compressionQuality: 1.0)!
                        multipartFormData.append(imgData , withName: "Thumb", fileName: "Thumb.jpg", mimeType: "image/jpeg")
                    }
                
                }
            }, to: "\(BASE_URL)\(endpointurl)", usingThreshold: UInt64.init(), method: .post, headers: additionalHeader).responseJSON { (encodingResult) in
                print(encodingResult)
                switch encodingResult.result
                {
                case .success :
                    if(encodingResult.value == nil)
                    {
                        hideLoaderHUD()
                        responseData(encodingResult.error as NSError?, nil)
                    }
                    else
                    {
                        let strResponse = encodingResult.value as! NSDictionary
                        /*let arr = strResponse.components(separatedBy: "\n")
                        let dict =  convertStringToDictionary(str:(arr.last  ?? "")!)
                        print(dict ?? "response is blank")*/
                        self.resObjects = dictionaryOfFilteredBy(dict: strResponse)
                        hideLoaderHUD()
                        responseData(nil,self.resObjects as? NSDictionary)
                    }
                    
                case .failure(_):
                    print("ENCODING ERROR: ",encodingResult.error as Any)
                    hideLoaderHUD()
                    responseData(encodingResult.error as NSError?, nil)
                }
            }
        }
    }
    
    func requestWithPostMultipartParam(endpointurl:String,
                                       isImage:Bool,
                                       parameters:NSDictionary,
                                       images:NSMutableArray = NSMutableArray(),
                                       showLoader:Bool,
                                       uploadfile : String = "",
                                       responseData:@escaping (_ error: NSError?, _ responseDict: NSDictionary?) -> Void)
    {
        if isConnectedToNetwork()
        {
            if showLoader {
                showLoaderHUD(strMessage: "")
            }
            
            print("URL : \(BASE_URL)\(endpointurl)")
            print("param : \(parameters)")
            
            alamoFireManager.upload(multipartFormData: { multipartFormData in
                if uploadfile.count > 0{
                    let last4Character  = uploadfile.suffix(4)
                    if last4Character == ".doc"{
                        let FileData :NSData = try! NSData(contentsOfFile: uploadfile)
                        multipartFormData.append(FileData as Data, withName: "resume", fileName: "resumeFile.doc", mimeType: "application/msword")
                        
                    }else if last4Character == ".pdf"{
                        let FileData :NSData = try! NSData(contentsOfFile: uploadfile)
                        multipartFormData.append(FileData as Data, withName: "resume", fileName: "resumeFile.pdf", mimeType: "application/pdf")
                    }
                }
                for (key, value) in parameters
                {
                    if value is URL {
                        let videoData :NSData = try! NSData(contentsOf: value as! URL,options: .mappedIfSafe)
                        multipartFormData.append(videoData as Data, withName: key as! String, fileName: "video.mp4", mimeType: "video/mp4")
                    }
                    else if value is UIImage {
                        let imgData = fixOrientationOfImage(image: (value as! UIImage))?.jpegData(compressionQuality: 1)
                        
                        multipartFormData.append(imgData! , withName: key as! String, fileName: "image.jpg", mimeType: "image/jpeg")
                    }
                    else if value is Data
                    {
                        multipartFormData.append(value as! Data, withName: key as! String, fileName: "image.jpg", mimeType: "image/jpeg")
                    }
                    else
                    {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as! String)
                    }
                }
                if images.count > 0 {
                    var cn = 0
                    for image in images {
//                        let dic:NSMutableDictionary = image as! NSMutableDictionary
//                        for (key, value) in dic
//                        {
                            if image is UIImage {
                                let imgData = fixOrientationOfImage(image: (image as! UIImage))?.jpegData(compressionQuality: 1)
                                multipartFormData.append(imgData!, withName: "File", fileName: "image\(cn).jpg", mimeType: "image/jpeg")
                                
                            }
                            else if image is URL {
                                let videoData :NSData = try! NSData(contentsOf: image as! URL,options: .mappedIfSafe)
                                multipartFormData.append(videoData as Data, withName: "File", fileName: "video.mp4", mimeType: "video/mp4")
                            }
                            else if image is Data
                            {
                                multipartFormData.append(image as! Data, withName: "File", fileName: "image\(cn).jpg", mimeType: "image/jpeg")
                                
                            }
//                        }
                        cn = cn + 1
                    }
                }
            }, to: "\(BASE_URL)\(endpointurl)", usingThreshold: UInt64.init(), method: .post, headers: additionalHeader).responseJSON { (encodingResult) in
                print(encodingResult)
                switch encodingResult.result
                {
                case .success :
                    if(encodingResult.value == nil)
                    {
                        hideLoaderHUD()
                        responseData(encodingResult.error as NSError?, nil)
                    }
                    else
                    {
                        let strResponse = encodingResult.value as! NSDictionary
                        /*let arr = strResponse.components(separatedBy: "\n")
                        let dict =  convertStringToDictionary(str:(arr.last  ?? "")!)
                        print(dict ?? "response is blank")*/
                        self.resObjects = dictionaryOfFilteredBy(dict: strResponse)
                        hideLoaderHUD()
                        responseData(nil,self.resObjects as? NSDictionary)
                    }
                    
                case .failure(_):
                    print("ENCODING ERROR: ",encodingResult.error as Any)
                    hideLoaderHUD()
                    responseData(encodingResult.error as NSError?, nil)
                }
            }
        }
    }
    
    func requestWithPostMediaUplaod(endpointurl:String,
                                    isImage:Bool,
                                    parameters:NSDictionary,
                                    images:NSMutableArray = NSMutableArray(),
                                    showLoader:Bool,
                                    uploadfile : String = "",
                                    responseData:@escaping (_ error: NSError?, _ responseDict: NSDictionary?) -> Void)
    {
        if isConnectedToNetwork()
        {
            if showLoader {
                showLoaderHUD(strMessage: "")
            }
            alamoFireManager.upload(multipartFormData: { multipartFormData in
                
                for (key, value) in parameters
                {
                    if value is Data
                    {
                        if uploadfile.count > 0{
                            let last4Character  = uploadfile.suffix(4)
                            if last4Character == ".doc"{
                                multipartFormData.append(value as! Data, withName: key as! String, fileName: "resumeFile.doc", mimeType: "application/msword")
                                
                            }else if last4Character == ".pdf"{
                                multipartFormData.append(value as! Data, withName: key as! String, fileName: "resumeFile.pdf", mimeType: "application/pdf")
                                
                            }
                        }
                    }
                    else
                    {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as! String)
                    }
                }
                if images.count > 0 {
                    var cn = 0
                    for image in images {
                        let dic:NSMutableDictionary = image as! NSMutableDictionary
                        for (key, value) in dic
                        {
                            if value is UIImage {
                                let imgData = fixOrientationOfImage(image: (value as! UIImage))?.jpegData(compressionQuality: 1)
                                multipartFormData.append(imgData!, withName: "files[\(cn)]", fileName: "image\(cn).jpg", mimeType: "image/jpeg")
                                
                            }
                            else if value is Data
                            {
                                multipartFormData.append(value as! Data, withName: "files[\(cn)]", fileName: "image\(cn).jpg", mimeType: "image/jpeg")
                                
                            }
                        }
                        cn = cn + 1
                    }
                }
            }, to: "\(BASE_URL)\(endpointurl)", usingThreshold: UInt64.init(), method: .post, headers: additionalHeader).responseJSON { (encodingResult) in
                switch encodingResult.result
                {
                case .success :
                    if(encodingResult.value == nil)
                    {
                        hideLoaderHUD()
                        responseData(encodingResult.error as NSError?, nil)
                    }
                    else
                    {
                        let strResponse = encodingResult.value as! String
                        let arr = strResponse.components(separatedBy: "\n")
                        let dict =  convertStringToDictionary(str:(arr.last  ?? "")!)
                        print(dict ?? "response is blank")
                        self.resObjects = dictionaryOfFilteredBy(dict: (dict as AnyObject) as! NSDictionary)
                        hideLoaderHUD()
                        responseData(nil,self.resObjects as? NSDictionary)
                    }
                    
                case .failure(_):
                    print("ENCODING ERROR: ",encodingResult.error as Any)
                    hideLoaderHUD()
                    responseData(encodingResult.error as NSError?, nil)
                }
            }
        }
    }
    //requestWithPostJsonParam
    func requestWithPostJsonParamWithFullURL( fullURL:String,
                                              parameters:NSDictionary,
                                              showLoader:Bool,
                                              completionHandler:@escaping (_ responseDict: NSDictionary?, _ error: NSError?) -> Void)
    {
        if isConnectedToNetwork()
        {
            if(showLoader) { showLoaderHUD(strMessage: "") }
            
            let strURL =  fullURL
            DLog(message: "URL : \(strURL) \nParam :\( parameters) ")
            
            print("Header Param :\(additionalHeader)")
            alamoFireManager.request(strURL, method: .post, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers: additionalHeader)
                .responseJSON { response in
                    hideLoaderHUD()
                    print("Response \(response)")
                    switch(response.result)
                    {
                    case .success(let value):
                        if let dic = value as? NSDictionary {
                            let message = dic["message"] as? String ?? ""
                            let status = dic["status"] as? String ?? ""
                            
                            if status == "2" {
                                showMessage(message)
                                logout()
                            }
                            
                        }
                        completionHandler(dictionaryOfFilteredBy(dict: (value as? NSDictionary)!), nil)
                        break
                    case .failure(let error):
                        completionHandler(nil, error as NSError?)
                        break
                    }
            }
        }
    }
    
    func requestWithPostJsonParam( service:String,
                                   parameters:NSDictionary,
                                   showLoader:Bool,
                                   isLoginMandatory:Bool = false,
                                   completionHandler:@escaping (_ responseDict: NSDictionary?, _ error: NSError?) -> Void)
    {
        if isConnectedToNetwork()
        {
            if(showLoader) { showLoaderHUD(strMessage: "") }
            
            let strURL = BASE_URL + service
            DLog(message: "URL : \(strURL) \nParam :\( parameters) ")
            
            print("Header Param :\(additionalHeader)")
            
            alamoFireManager.request(strURL, method: .post, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers: additionalHeader)
                .responseJSON { response in
                    if(showLoader) {
                    hideLoaderHUD()
                    }
                    print("Response \(response)")
                    switch(response.result)
                    {
                    case .success(let value):
                        if let dic = value as? NSDictionary {
                            let message = dic["message"] as? String ?? ""
                            let status = dic["status"] as? String ?? ""
                            
                            if status == "2" {
                               // showMessage(message)
                                logout()
                            }
                            
                        }
                        completionHandler(dictionaryOfFilteredBy(dict: (value as? NSDictionary)!), nil)
                        break
                    case .failure(let error):
                        completionHandler(nil, error as NSError?)
                        break
                    }
            }
        }
    }
    
    
    //MARK: GET
    func getRequestWithStory(service:String,
                    showLoader:Bool,
                    urlParam:String? = "",
                    completionHandler:@escaping (_ responseDict: NSDictionary?, _ error: NSError?) -> Void)
    {
        if isConnectedToNetwork()
        {
            if(showLoader) { showLoaderHUD(strMessage: "") }
            print("Header Param :\(additionalHeader)")
            let escapedString = urlParam?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            print(escapedString!)
            var strURL = "\(BASE_URL)\(service)?\(escapedString ?? "")"
            
            print(strURL)
//            strURL = escapedString ?? ""
            alamoFireManager.request(strURL, method: .get, parameters:nil , encoding: JSONEncoding.default, headers: additionalHeader)
                .responseJSON { response in
                    hideLoaderHUD()
                    print("Response \(response)")
                    switch(response.result)
                    {
                    case .success(let value):
                        completionHandler(value as? NSDictionary, nil)
                        break
                    case .failure(let error):
                        completionHandler(nil,error as NSError?)
                        
                        break
                    }
            }
        }
    }
    func getRequest(service:String,
                    showLoader:Bool,
                    urlParam:String? = "",
                    completionHandler:@escaping (_ responseDict: NSDictionary?, _ error: NSError?) -> Void)
    {
        if isConnectedToNetwork()
        {
            if(showLoader) { showLoaderHUD(strMessage: "") }
            print("Header Param :\(additionalHeader)")
            let escapedString = urlParam?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            print(escapedString!)
            var strURL = "\(BASE_URL)\(service)?\(escapedString ?? "")"
            
            print(strURL)
//            strURL = escapedString ?? ""
            alamoFireManager.request(strURL, method: .get, parameters:nil , encoding: JSONEncoding.default, headers: additionalHeader)
                .responseJSON { response in
                    hideLoaderHUD()
                    print("Response \(response)")
                    switch(response.result)
                    {
                    case .success(let value):
                        completionHandler(dictionaryOfFilteredBy(dict: (value as? NSDictionary)!), nil)
                        break
                    case .failure(let error):
                        completionHandler(nil,error as NSError?)
                        
                        break
                    }
            }
        }
    }
    
    //MARK: PUT
    func putRequest(service:String,
                    showLoader:Bool,
                    urlParam:String? = "",
                    parameters : NSMutableDictionary,
                    completionHandler:@escaping (_ responseDict: NSDictionary?, _ error: NSError?) -> Void)
    {
        if isConnectedToNetwork()
        {
            if(showLoader) { showLoaderHUD(strMessage: "") }
            print("Header Param :\(additionalHeader)")
            var strURL = "\(BASE_URL)\(service)"
            if urlParam!.count > 0 {
                strURL = "\(strURL)/\(urlParam ?? "")"
            }
            print(strURL)
            if parameters != nil {
                print(parameters)
            }
            alamoFireManager.request(strURL, method: .put, parameters:parameters as? Parameters , encoding: JSONEncoding.default, headers: additionalHeader)
                .responseJSON { response in
                    hideLoaderHUD()
                    print("Response \(response)")
                    switch(response.result)
                    {
                    case .success(let value):
                        completionHandler(dictionaryOfFilteredBy(dict: (value as? NSDictionary)!), nil)
                        break
                    case .failure(let error):
                        completionHandler(nil,error as NSError?)
                        
                        break
                    }
            }
        }
    }
    func putRequest(service:String,
                    showLoader:Bool,
                    urlParam:String? = "",
                    completionHandler:@escaping (_ responseDict: NSDictionary?, _ error: NSError?) -> Void)
    {
        if isConnectedToNetwork()
        {
            if(showLoader) { showLoaderHUD(strMessage: "") }
            print("Header Param :\(additionalHeader)")
            let strURL = "\(BASE_URL)\(service)/\(urlParam ?? "")"
            print(strURL)
            alamoFireManager.request(strURL, method: .put, parameters:nil , encoding: JSONEncoding.default, headers: additionalHeader)
                .responseJSON { response in
                    hideLoaderHUD()
                    print("Response \(response)")
                    switch(response.result)
                    {
                    case .success(let value):
                        completionHandler(dictionaryOfFilteredBy(dict: (value as? NSDictionary)!), nil)
                        break
                    case .failure(let error):
                        completionHandler(nil,error as NSError?)
                        
                        break
                    }
            }
        }
    }
    
    //MARK: Convert InTo Json String
    func jsonToString(json: AnyObject) -> String{
        do {
            let data1 = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            let convertedString = String(data: data1, encoding: String.Encoding.utf8)
            return convertedString!
        } catch let myJSONError {
            print(myJSONError)
            return ""
        }
    }
    
    
    
    class func requestWithDefaultCalling( service:String,
                                          parameters:NSMutableDictionary,
                                          showLoader:Bool = true,
                                          completionHandler:@escaping (_ responseDict: NSDictionary?, _ error: NSError?) -> Void)
    {
//        let dToken = UserDefaults.standard.value(forKey: UD_Device_Token) as? String ?? "123"
        
        parameters.setValue(kLengType, forKey: "langType")
        parameters.setValue(kDeviceType, forKey: "deviceType")
//        parameters.setValue(dToken, forKey: "deviceToken")
        parameters.setValue(UIDevice.current.identifierForVendor!.uuidString, forKey: "deviceId")
        parameters.setValue(TimeZone.current.identifier, forKey: "timeZone")
        
        let param: NSDictionary = ["data": parameters]
        
        HttpRequestManager().requestWithPostJsonParam(service: service, parameters: param, showLoader: showLoader, completionHandler: completionHandler)
        
    }
}
