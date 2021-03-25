//
//  Constants.swift
//
//  Created by Parth Hirpara
//

import Foundation
import UIKit

let GET = "GET"
let POST = "POST"
let MEDIA = "MEDIA"

let DEFAULT_TIMEOUT:TimeInterval = 60.0

let kLengType   =   "1"
let kDeviceType =   "1"
//let kRole   = "2"

//MARK: Response Keys
let kData       =   "data"
let kMessage    =   "Message"
let kSuccess    =   "success"
let kToken      =   "token"
let kStatus     =   "Status"



//let kStatusFailure = "0"
//let kStatusSuccess = "1"
//let kStatusUserNotVeryfy = "3"
//let kStatusNoRecord = "6"
//let kStatusEmailNotAdded = "4"

let kStatusFailure = "0"
let kStatusSuccess = "1"
let kStatusUserNotVeryfy = "400"
let kStatusNoRecord = "6"
let kStatusEmailNotAdded = "4"


let BASE_URL =
""

//let WS_URL = "" // test

let BASE_URL_FOR_IMAGE = "\(BASE_URL)/Files/" //test

let PrivacyAndPolicyURL    =   "\(BASE_URL)/Terms.html"

let kGoogleAPIKey                   =  "AIzaSyC5NFJNqFQhNlC17dpJ6kXI4RXQecXJgOo" //
let kGoogleClientKey                =   "365283045462-djclri8jajq5qvo5ae618vd0rvupveil.apps.googleusercontent.com"
let kGooglePlaceKey                 =   "262783297242-328sj894pmr92e53e82pcdgd63jj35pn.apps.googleusercontent.com"

let kFBURLScheme                    =   "fb435602930699955"
let kGoogleURLScheme                =   "com.googleusercontent.apps.365283045462-djclri8jajq5qvo5ae618vd0rvupveil"


//WEb Socket URl
let kUserSupportTicketMessageList                =   "userSupportTicketMessageList"
let kUserSupportTicketReply                      =   "userSupportTicketReply"
let kChatinbox                                   =   "chatinbox"
let kChatmessagelist                             =   "chatmessagelist"
let kUsermessagelist                             =   "usermessagelist"
let kmessage                                     =   "message"
let kAcceptRequest                               =   "acceptRequest"
let kDeclineRequest                              =   "declineRequest"


let kGetCountry_URL                 =   "https://geodata.solutions/api/api.php?type=getCountries&orderby=alpha"
let kGetState_URL                   =   "https://geodata.solutions/api/api.php?type=getStates&countryId="
let kGetCity_URL                    =   "https://geodata.solutions/api/api.php?type=getCities&countryId="
let kMap_URL                        =   "https://maps.googleapis.com/maps/api/geocode/json?"


//MARK:- API URL

let kSignUp             =   "/api/v1/User"

