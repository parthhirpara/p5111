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


let BASE_URL = //"http://192.168.22.13:8079"
//"http://3.17.152.93:8082"
"http://3.137.131.252:8082"

//let WS_URL = "ws://project.greatwisher.com:9006" // test

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
let kSignupVerify       =   "/api/v1/Account/VerifyEmail"
let kVerifyResend       =   "/api/v1/User/ResendCode"
let kVerifyResendForgot =   "/api/v1/User/ResendForgetPasswordCode"
let kForgotPassword     =   "/api/v1/User/ForgetPassword"
let kForgotCodeVerify   =   "/api/v1/User/VerifyForgetCode"
let kSetNewPassword     =   "/api/v1/User/ChangeAccountPassword"
let kLogin              =   "/api/v1/Account/login"
let kSetUIDAPI          =   "/api/v1/User/AddUid"
let kUpdateLocationAPI  =   "/api/v1/User/UpdateLocation"
let kCheckUserName      =   "/api/v1/User/UsernameExist"
let kCheckEmailExist    =   "/api/v1/User/EmailExist"
let kUpdateUserInfo     =   "/api/v1/User/UpdateUserProfile/"
let kChangePasswordAPI  =   "/api/v1/User/ChangePasswordWithFirebase"
let kUploadUserProfile  =   "/api/v1/User/UploadProfilePic"
let kUpdateBioAPI       =   "/api/v1/User/UpdateBio/"
let kGetMyCircleListAPI =   "/api/v1/User/GetMyConnectionByType"
let kGetFriendCircleListAPI =   "/api/v1/User/GetFriendsConnectionByType"
let kSetSettingsDataAPI =   "/api/v1/User/UserSetting"
let kSetSettingInfoAPI  =   "/api/v1/User/GetUserSetting"

//Privacy
let kSetImagePostPrivacyAPI =   "/api/v1/Privacy/UpdatePicmeePrivacy"
let kSetBlogPostPrivacyAPI  =   "/api/v1/Privacy/UpdateBlogPrivacy"
let kSetVideoPostPrivacyAPI =   "/api/v1/Privacy/UpdateMoviePrivacy"
let kGetPrivacyListAPI      =   "/api/v1/Privacy/GetPrivacyByUserId/"
let kUpdatePrivacyListAPI   =   "/api/v1/Privacy/UpdateUserPrivacy"

//Report
let kPostReportinAPI        =   "/api/v1/User/Report"

//Badges
let kGetBadgesAPI           =   "/api/v1/User/GetBadge/"
let kUserClearBadgesAPI     =   "/api/v1/User/ClearBadge/"

//Friend
let kSendConnectionRequest      =   "/api/v1/Friends/SendConnectionRequest"
let kGetRequstListAPI           =   "/api/v1/Friends/GetConnectionRequests"
let kCancelFriendRequestAPI     =   "/api/v1/Friends/CancelConnectionRequest"
let kCancelFriendPendingRequestAPI  =   "/api/v1/Friends/CancelSendRequest"
let kAcceptFriendRequestAPI     =   "/api/v1/Friends/RespondToConnectionRequest"
let kRemoveFriendInCircleAPI    =   "/api/v1/Friends/RemoveConnection"
let kChangeCircleAPI            =   "/api/v1/Friends/ChangeCircle"

//User
let kGetUserListAPI     =   "/api/v1/user/FindFriendUser/"
let kGetUserSearchAPI   =   "/api/v1/User/SearchUser"
let kGetUserInfoAPI     =   "/api/v1/User"
let kGetUserInfoFromUIDAPI      =   "/api/v1/User/GetInformationByUid"
let kGetOtherUserInfoAPI        =   "/api/v1/user/GetFriendUserInformation"
let kGetUserNotificationAPI     =   "/api/v1/user/GetNotifications"
let kDeleteNotificationAPI      =   "/api/v1/user/DeleteUserNotification"
let kUserLogoutAPI              =   "/api/v1/Account/Logout"
    
//blog
let kBlogAddAPI             =   "/api/v1/Blog"
let kGetBlogListAPI         =   "/api/v1/Blog/GetPaged/"
let kGetMyBlogListAPI       =   "/api/v1/Blog/GetMyBlogList/"
let kBlogLikeAPI            =   "/api/v1/Blog/BlogLikes"
let kGetBlogmeeByIDAPI      =   "/api/v1/blog/GetBlogDetailsById"
let kDeleteBlogMeeAPI       =   "/api/v1/Blog"
let kUpdateBlogPostAPI      =   "/api/Blog/UpdateBlog"

//pickmee
let kGetImagesListAPI   =   "/api/v1/Picmee/"
let kGetImageByIDAPI    =   "/api/v1/Picmee/GetPicmeeDetailsById"
let kImagesPostLikeAPI  =   "/api/v1/Picmee/PicmeeLikes"
let kImagePostUploadAPI =   "/api/v1/Picmee"
let kMyImagePostListAPI =   "/api/v1/Picmee/GetMyPicmeeList/"
let kDeletePicMeeAPI    =   "/api/v1/Picmee"
let kUpdatePicmeePOSTAPI    =   "/api/v1/Picmee/UpdatePicmee"

//videos
let kVideoPostLikeAPI   =   "/api/v1/Watchmee/WatchmeeLikes"
let kGetVideosListAPI   =   "/api/v1/Watchmee/GetPaged/"
let kGetVideosByIDAPI   =   "/api/v1/Watchmee/GetWatchmeeDetailsById"
let kGetMyVideosListAPI   =   "/api/v1/Watchmee/GetMyWatchmeeList/"
let kVideoPostUploadAPI =   "/api/v1/Watchmee/AddMovie"
let kUploadVideoThumb   =   "/api/v1/Watchmee/VideoUpload"
let kDeleteWhatchmeeAPI =   "/api/v1/Watchmee"
let kUpdateVideoPostAPI =   "/api/v1/Watchmee/UpdateMovie"

//Story
let kAddStoryAPI        =   "/api/v1/Story/AddStory"
let kGetStorysAPI       =   "/api/v1/Story/GetAllStoryList/"
