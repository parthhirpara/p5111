//
//  Utility.swift
//
//  Created by Developer on 13/03/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
import SVProgressHUD
import AVKit
import AVFoundation

class FlowLayout: UICollectionViewFlowLayout {

    required init(minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        super.init()

        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
        sectionInsetReference = .fromSafeArea
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        guard scrollDirection == .vertical else { return layoutAttributes }

        // Filter attributes to compute only cell attributes
        let cellAttributes = layoutAttributes.filter({ $0.representedElementCategory == .cell })

        // Group cell attributes by row (cells with same vertical center) and loop on those groups
        for (_, attributes) in Dictionary(grouping: cellAttributes, by: { ($0.center.y / 10).rounded(.up) * 10 }) {
            // Set the initial left inset
            var leftInset = sectionInset.left

            // Loop on cells to adjust each cell's origin and prepare leftInset for the next cell
            for attribute in attributes {
                attribute.frame.origin.x = leftInset
                leftInset = attribute.frame.maxX + minimumInteritemSpacing
            }
        }

        return layoutAttributes
    }

}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}

class Utility {
    
    // Display Alert Message
    class func showAlert(_ title: String,
                         message: String,
                         actions:[UIAlertAction] = [UIAlertAction(title: "OK", style: .cancel, handler: nil)]) {
        if checkAlertExist() == false {
            
            Utility.dismissProgress()

            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            for action in actions {
                alert.addAction(action)
            }
            
            let tab =  UIApplication.shared.delegate?.window!?.rootViewController as? UITabBarController
            
            if tab != nil {
                let nav = tab?.selectedViewController as? UINavigationController
                nav?.present(alert, animated: true, completion: nil)
            } else if let nav =  UIApplication.shared.delegate?.window!?.rootViewController as? UINavigationController {
//                UIApplication.inputViewController()?.present(nav, animated: true, completion: nil)
                nav.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    class func checkAlertExist() -> Bool {
        for window: UIWindow in UIApplication.shared.windows {
            if (window.rootViewController?.presentedViewController is UIAlertController) {
                return true
            }
        }
        return false
    }
    
    //gradient Color Class
    @IBDesignable class GraphView: UIView {
        
        // 1
        @IBInspectable var startColor: UIColor = .red
        @IBInspectable var endColor: UIColor = .green
        
        override func draw(_ rect: CGRect) {
            
            // 2
            let context = UIGraphicsGetCurrentContext()!
            let colors = [startColor.cgColor, endColor.cgColor]
            
            // 3
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            
            // 4
            let colorLocations: [CGFloat] = [0.0, 1.0]
            
            // 5
            let gradient = CGGradient(colorsSpace: colorSpace,
                                      colors: colors as CFArray,
                                      locations: colorLocations)!
            
            // 6
            let startPoint = CGPoint.zero
            let endPoint = CGPoint(x: 0, y: bounds.height)
            context.drawLinearGradient(gradient,
                                       start: startPoint,
                                       end: endPoint,
                                       options: [])
        }
    }
    
    
    
    // Find Color From Hex Value
    class func UIColorFromHex(hex:String, alpha:Double = 1.0) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    
    // Display ProgressHUD
    class func showProgress(_ message: String) {
        SVProgressHUD.setDefaultMaskType(.clear)
        if(message == "") {
            SVProgressHUD.show()
        }
        else {
            SVProgressHUD.show(withStatus: message)
        }
    }
    
    class func updateProgress(value val:Float, withString str:String = "") {
        SVProgressHUD.showProgress(val, status: str)
    }
    
    class func dismissProgress() {
       SVProgressHUD.dismiss()
    }
    
  
    
    // MARK: convert local date & time to UTC
    class func localToUTC(date:String, fromFormat: String, toFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.date
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = toFormat
        
        return dateFormatter.string(from: dt!)
    }
    
    // MARK: Set Hastag
   class func setHashtagAndMention(_ stringWithTags: String?) -> NSMutableAttributedString? {
        var _: Error? = nil
        let regex = try? NSRegularExpression(pattern: "[#|@]+[A-Za-z0-9_^]+", options: [])
        let matches = regex?.matches(in: stringWithTags ?? "", options: [], range: NSRange(location: 0, length: stringWithTags?.count ?? 0))
        let attString = NSMutableAttributedString(string: stringWithTags ?? "")
        let stringLength: Int = stringWithTags?.count ?? 0
        for match in matches ?? [] {
            let wordRange: NSRange = match.range(at: 0)
            _ = (stringWithTags as NSString?)?.substring(with: wordRange)
            let font = UIFont(name: "SFUIDisplay-Light", size: 15.0)
            attString.addAttribute(.font, value: font, range: NSRange(location: 0, length: stringLength))
            let backgroundColor = #colorLiteral(red: 0.6117647059, green: 0.231372549, blue: 0.4941176471, alpha: 1)
            attString.addAttribute(.foregroundColor, value: backgroundColor, range: wordRange)
        }
        
        return attString
    }
    
    class func downloadImageFromURL(imgURL: URL) -> UIImage? {
        if let data = try? Data(contentsOf: imgURL) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }

    class func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    // MARK: Convert UTC date & time to local
    class func UTCToLocal(date:String, fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = toFormat
        
        return dateFormatter.string(from: dt!)
    }
    
    class func convertDateFormate(forStringDate strDate: String, currentFormate: String, newFormate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormate
        let dateObj = dateFormatter.date(from: strDate)
        dateFormatter.dateFormat = newFormate
        return dateFormatter.string(from: dateObj!)
    }
    
    class func getStringDateFromDate(dateFormat:String,enterDate:Date) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = dateFormat
        let strDate = dateFormater.string(from: enterDate)
        return strDate
    }
    
    class func getDateFromString(strDate: String, currentFormate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormate
        let dateObj = dateFormatter.date(from: strDate)
        return dateObj!
    }
    
    class func dayDifference(msgDate:Date) -> String {
        let calendar = NSCalendar.current
        let date = msgDate//Date(timeIntervalSince1970: interval)
        if calendar.isDateInYesterday(date) { return "Yesterday" }
        else if calendar.isDateInToday(date) { return "Today" }
        else if calendar.isDateInTomorrow(date) { return "Tomorrow" }
        else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
            let now = dateFormatter.string(from: msgDate)
            return now
        }
    }
    
    class func replaceHTMLEntitiesInString(htmlString:String) -> String {
        var htmlStr:String = htmlString
        htmlStr = htmlStr.replacingOccurrences(of: "&nbsp;", with: "")
        htmlStr = htmlStr.replacingOccurrences(of: "&quot;", with: "")
        htmlStr = htmlStr.replacingOccurrences(of: "&lt;", with: "")
        htmlStr = htmlStr.replacingOccurrences(of: "&gt;", with: "")
        return htmlStr
    }
    
    
    // MARK: - Get SnapShot From Video Methods
    class func videoSnapshot(fileURL: URL, completion:@escaping ((UIImage?)->())) {
        DispatchQueue.global().async {
            let asset = AVURLAsset(url: fileURL)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true
            
            let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
            
            do {
                let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
                DispatchQueue.main.async {
                    completion(UIImage(cgImage: imageRef))
                }
            }
            catch let error as NSError
            {
                print("Image generation failed with error \(error)")
                completion(nil)
            }
        }
    }
   
    
    class func loadJson(forFilename fileName: String) -> NSDictionary? {
        
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            if let data = NSData(contentsOf: url) {
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSDictionary
                    
                    return dictionary
                } catch {
                    print(error.localizedDescription)
                    fatalError(error.localizedDescription)
                }
            }
        }
        
        return nil
    }
    
    class func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                let dic = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                print(dic)
                return dic
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
//    class func setLastOpenedScreen(screenName: LastScreen) {
//        USERDEFAULTS.set(screenName.rawValue, forKey: UDKey.kLastOpenedScreen)
//    }
    
//    class func getLastOpenedScreen() -> LastScreen {
//        guard let lastScreen = USERDEFAULTS.value(forKey: UDKey.kLastOpenedScreen) as? String else {
//            return .defaultScreen
//        }
//        return LastScreen(rawValue: lastScreen)!
//    }
    
    
    class func setHeaderMetaForHTML(_ htmlStr: String) -> String {
        return "<html><head><meta name='viewport' content='width=device-width, initial-scale=1'></head><body>\(htmlStr)</body></html>"
    }
}




//class LogHelper: NSObject {
//    
//    static let shared = LogHelper()
//    
//    let fileName    =   "logfile.txt"
//    var documentDir =   FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//    
//    var filePath: URL {
//        get {
//            return documentDir.appendingPathComponent(fileName)
//        }
//    }
//    
//    private override init() {
//        super.init()
//    }
//    
//    func logToFile(_ str: String) {
//        print(str)
//        
//        let log = getFileLog() + "\n" + Date().toString(withFormate: "yyyy-MM-dd hh:mm:ss") + "   " + str
//        
//        do {
//            try log.write(to: filePath, atomically: false, encoding: .utf8)
//        }
//        catch {
//            print("Can't write to file because of: ",error.localizedDescription)
//        }
//    }
//    
//    func clearLog() {
//        do {
//            try FileManager.default.removeItem(at: filePath)
//        } catch { }
//    }
//    
//    func getFileLog() -> String {
//        do {
//            return try String(contentsOf: filePath, encoding: .utf8)
//        } catch { }
//        return ""
//    }
//    
//}
extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}
