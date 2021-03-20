//
//  KeyNamesConstants.swift
//  Parth Hirpara
//

import Foundation
import UIKit

//import FirebaseCore
//import FirebaseFirestore



let APP_DELEGATE                =   UIApplication.shared.delegate as! AppDelegate
let kAppDelegate                =   UIApplication.shared.delegate as! AppDelegate
//let kRootViewController         =   kAppDelegate.window?.rootViewController
let kMainStoryBoard             =   UIStoryboard(name: "Main", bundle: nil)
let kLoginStoryBoard            =   UIStoryboard(name: "Login", bundle: nil)
let USERDEFAULTS                =   UserDefaults.standard

public let defaultShimmerValue  :   Int = 10

public let deviceType   :   Int =   1

//MARK:- Alert Button

public let kOK                      :   String  =   "Ok"
public let kCancel                  :   String  =   "Cancel"
public let kDelete                  :   String  =   "Delete"
public let kEdit                    :   String  =   "Edit"
public let kUnSelect                :   String  =   "Unselect"
public let kMale                    :   String  =   "Male"
public let kFeMale                  :   String  =   "Female"
public let kOther                   :   String  =   "Other"
public let kInarelationship         :   String  =   "In a relationship"
public let kItisreallycomplicated   :   String  =   "It is really complicated"
public let kRemoveBtn               :   String  =   "Remove"
public let kChangeCircle            :   String  =   "Change circle"
public let kHappylikeitis           :   String  =   "Happy like it is!"
public let kFriends                 :   String  =   "Friends"
public let kConnection              :   String  =   "Connection"
public let kFamily                  :   String  =   "Family"
public let kPublic                  :   String  =   "Public"
public let kOnlyMe                  :   String  =   "OnlyMe"
public let kReport                  :   String  =   "Report"
public let kShareButton             :   String  =   "Share"
public let kCancelRequest           :   String  =   "Cancel Request"
public let kRemoveFormConnection    :   String  =   "Remove from connection"
public let kAround500m              :   String  =   "Around 500m"
public let kAround1km               :   String  =   "Around 1km"
public let kAllButton               :   String  =   "All"


public let datePickerDone           :   String  =   "Done"
public let datePickerCancel         :   String  =   "Cancel"


public let openStatus               :   String  =   "Open"
public let CloseStatus              :   String  =   "Close"
public let InActiveStatus           :   String  =   "Inactive"

//MARK:- Button
public let kUploadYourPostName      :   String  =   "UPLOAD YOUR POST"
public let kUpdateYourPost          :   String  =   "UPDATE YOUR POST"

//MARK:- APP NAME
public let APPNAME :String = "ItsMee"

let loadercolor = [themeBlueColor, themeGreenColor]

//MARK: Const
public let bottomInset              :   Float   =   150

//MARK:- Firebase
//let db = Firestore.firestore()


//MARK:- Home Title
public let Home_All             :   String  =   "All"
public let Home_Friends         :   String  =   "Friends"
public let Home_Connection      :   String  =   "Connection"
public let Home_Family          :   String  =   "Family"
public let Home_HelloWold       :   String  =   "Hello World"

//MARK:- Notification name
public let Notification_Menu_Open   :   String  =   "Notification_Menu_Open"
public let Notification_Menu_Update :   String  =   "Notification_Menu_Update"
public let Notification_StoryClick  :   String  =   "Notification_StoryClick"

//MARK:- Language
public let Language_English         :   String  =   "English"
public let Language_Spanish         :   String  =   "Spanish"

//MARK:- Mode
public let Mode_Light           :   String  =   "Light"
public let Mode_Dark            :   String  =   "Dark"

//MARK:- USER DEFAULT
public  let UD_Device_Token         :   String  =   "DeviceToken"
public  let UD_Rememer_Me           :   String  =   "UD_Rememer_Me"
public  let UD_TouchID_On_Off       :   String  =   "UD_TouchID_On_Off"
public  let UD_Theam_Mode_IS_DARK   :   String  =   "UD_Theam_Mode_IS_DARK"
public  let UD_User_Token           :   String  =   "UD_User_Token"

//MARK:- Lable
let LabelReadMore   :   String  =   "Read More"
let LabelReadLess   :   String  =   "Read Less"

//MARK:- COLOR NAMES
let APP_COLOR       =   Color_Hex(hex: "#002E5D")
let themeBlueColor  =   APP_COLOR
let themeGreenColor =   Color_Hex(hex: "#5EDA75")

struct ObserverName {
    static let kcontentSize     = "contentSize"
}

//MARK:- Connection Type
public let ConnectionNotYetConnection       :   String  =   "Add"
public let ConnectionPendingConnection      :   String  =   "Pending"
public let ConnectionAlreadyInvited         :   String  =   "Invited"
public let ConeectionAlreadyConnection      :   String  =   "Connection"

//MARK:- Relation Type
public let RelationRequestFor  : String =   "Request for"
public let RelationFriend       :   String  =   "friend"
public let RelationFamily       :   String  =   "family"
public let RelationConnection   :   String  =   "connection"
public let RelationPublic       :   String  =   "public"

//MARK:- PostType
public let postFriend       :   String  =   "Friend"
public let postConnection   :   String  =   "Connection"
public let postFamily       :   String  =   "Family"
public let postPublic       :   String  =   "Public"
public let postOnlyMe       :   String  =   "OnlyMe"

//Chat
public let ChatOffline      :   String  =   "Offline"
public let ChatOnline       :   String  =   "Online"

//MARK:- Relationship Status
public let Relationship_Single      :   String      =   "Single"
public let Relationship_Married     :   String      =   "Married"

//MARK: CircleRelationship type
public let circleRelationshipConnection     :   String  =   "Connection"
public let circleRelationshipFriends        :   String  =   "Friends"
public let circleRelationshipFamily         :   String  =   "Family"
public let circleRelationshipPublic         :   String  =   "Public"

//MARK:- Eye Color
public let EyeColor_Amber           :   String  =   "Amber"
public let EyeColor_Blue            :   String  =   "Blue"
public let EyeColor_Brown           :   String  =   "Brown"
public let EyeColor_Gray            :   String  =   "Gray"
public let EyeColor_Green           :   String  =   "Green"
public let EyeColor_Hazel           :   String  =   "Hazel"
public let EyeColor_Red             :   String  =   "Red"

//MARK:- Search Button Title
public let SearchAddCircle              :   String  =   "Add Circle"
public let SearchSendFriendReuest       :   String  =   "Send friend request"
public let SearchSendConnectionRequest  :   String  =   "Send connection request"
public let SearchSendFamilyRequest      :   String  =   "Send family request."
public let SearchSendPublicRequest      :   String  =   "Send public request"
public let SearchPendingRequest         :   String  =   "Pending request"
public let SearchRequstSend             :   String  =   "Already invited "
public let SearchAlreadyConnection      :   String  =   "Already Connection"

//MARK:- Model
public  let kModelUserInfo          :   String      =   "ModelUserInfo"
public  let kModelGetBadges         :   String      =   "ModelGetBadges"

//MARK:- POPUp Message
public let kPopupLikeTitle          :   String      =   "How many minutes do you want to donate?"
public let kPopupDislikeTitle       :   String      =   "How many minutes do you want to take?"
public let kFaseIDDisableMSG        :   String      =   "FaceID or TouchID is disable"
public let kMsgPasscodeProblemVerifyingYourIdentity :   String  =   "There was a problem verifying your identity."
public let kMsgPasscodeProcessCancel    :   String  =   "You pressed cancel."
public let kMsgYouPressPassword     :   String  =   "You pressed password."
public let kMsgPasscodeFaceCodeNotAvailable :   String  =   "Face ID/Touch ID is not available."
public let kMsgPasscodeFaceCodenotSet   :   String  =   "Face ID/Touch ID is not set up."
public let kMsgPasscodeFaceIDislocked   :   String  =   "Face ID/Touch ID is locked."
public let kMsgPasscodeFaceidnotBeConfige   :   String  =   "Face ID/Touch ID may not be configured"


//MARK:- Label Read more/ less
public let kLabelReadMore       :   String  =   "...ReadMore"
public let kLabelReadLess       :   String  =   "...ReadLess"
public let kCharacterBeforReadMore : Int =  20

//MARK:- Popup Title
public let kPopupLikeOkButtonTitle  :   String      =   "Donate"
public let kPopupDislikeOkButtonTitle   :   String  =   "Take"

public let kNoDataAvailable     :   String  =   "No data available."

//MARK:- Alert Message
public let msgSendRequestToFriend       :   String  =   "Are you sure you want to send request for friends?"
public let msgSendRequestToConnection   :   String  =   "Are you sure you want to send request for connection?"
public let msgSendRequestToFamily       :   String  =   "Are you sure you want to send request for family?"
public let msgSendRequestToPublic       :   String  =   "Are you sure you want to send request for public?"
public let msgDeclineRequest            :   String  =   "Are you sure you want to cancel request?"
public let msgRemoveFriendInCircleAlert :   String  =   "Are you sure you want to remove user in this circle?"
public let msgDeletePost                :   String  =   "Are you sure you want to delete this post?"
public let msgPostIsExpire              :   String  =   "Your post is expire."


//MARK:- Firebase Error message
public let msgFirebase      :   String  =   "Please forgot your password."

//MARK:- API Message
public let ProfileUpdateSuccess             :   String  =   "Profile update success."
public let verifySuccessMsg                 :   String  =   "Verify success"
public let resendVerifyMsg                  :   String  =   "Verify code resend success."
public let signupSuccess                    :   String  =   "Signup success."
public let settingInfoUpdateSuccessMsg      :   String  =   "Setting info update successfully."
public let imagePostAddSuccess              :   String  =   "Your post add successfully"
public let videoPostAddSuccess              :   String  =   "Your video post add successfully"
public let updateImagePostSuccess           :   String  =   "Post update successfully."
public let setNewPasswordMsg                :   String  =   "Set new password success."
public let msgPasswordChange                :   String  =   "Password changes successfully"
public let msgRequestSendSuccess            :   String  =   "Your request send successfully."
public let msgCircleChangeSuccess           :   String  =   "Circle change successfully."
public let msgUserReportSendSuccess         :   String  =   "User report send successfully."
public let msgPostLikeSuccess               :   String  =   "Post like successfully."
public let msgPostDislikeSuccess            :   String  =   "Post dislike successfully."
public let msgBioUpdateSuccess              :   String  =   "User bio update success."
public let msgFriendRequstCancellSuccess    :   String  =   "Request decline successfully."
public let msgFriendRequstAcceptlSuccess    :   String  =   "Request accept successfully."
public let msgPrivacyUpdateSuccess          :   String  =   "Privacy update successfully."
public let msgReportPostSuccess             :   String  =   "Report post successfully."
public let msgRemoveFriendInCircle          :   String  =   "User remove in your circle successfully."
public let msgForgotCodeSend                :   String  =   "Forgot code send successfully."
public let msgFirebaseDeleteChatMsg         :   String  =   "Delete chat successfully."
public let msgAlDeleteChat                  :   String  =   "Are you sure you want to delete this chat?"
public let msgNotificationDeleteSuccess     :   String  =   "Notification delete successfully."
public let msgAddStorySuccessfully          :   String  =   "Story add successfully."

//MARK:- Message
public let InternetNotAvailable             :   String  =   "Please connect internet."
public let RetryMessage                     :   String  =   "Something went wrong please try again..."
public let msgAddLibraryPermitionssion      :   String  =   "you have not set library permission in ItsMee"//"add library permission"
public let msgAddCameraPermitionsstion      :   String  =   "you have not set camera permission in ItsMee"//"add camera permission"

public let EmptyFirstName                   :   String  =   "Please enter first name."
public let EmptyLastName                    :   String  =   "Please enter last name."
public let EmptyUserName                    :   String  =   "Please enter user name."
public let EmailEmpty                       :   String  =   "Please enter email."
public let EmailNotValid                    :   String  =   "Please enter valide email."
public let EmptyPassword                    :   String  =   "Please enter password."
public let EmptyCurrentPassword             :   String  =   "Please enter current password"
public let PasswordNotValid                 :   String  =   "Please enter minimum 8 character [A-Z], [a-z], [0-9]"
public let EmptyDateOfBirth                 :   String  =   "Please select date of birth."
public let EmptyCountry                     :   String  =   "Please select country."
public let EmptyCity                        :   String  =   "Please enter city."
public let EmptyConfirmPassword             :   String  =   "Please enter confirm password."
public let PasswordAndConfirmPWDNotSame     :   String  =   "Please enter same password and confirm password."
public let EmptyGender                      :   String  =   "Please select gender."
public let EmptyOTP                         :   String  =   "Please enter otp."
public let EmptyUploadTitle                 :   String  =   "Please enter title."
public let EmptyUploadDesc                  :   String  =   "Please enter description."
public let EmptyTimeSelect                  :   String  =   "Please select time."
public let UserNameExist                    :   String  =   "Please change your user-name."
public let EmailExist                       :   String  =   "Please change your email address."
public let UploadPostCircleNotAdd           :   String  =   "Please select circle."
public let uploadPostImageEmpty             :   String  =   "Please select image."
public let uploadPostVideoEmpty             :   String  =   "Please select video."
public let logoutConfirm                    :   String  =   "Are you sure you want to logout?"
public let msgReportNotSelect               :   String  =   "Please select any report option."
public let msgReportOtherIntoNotWrite       :   String  =   "Please write something."
public let msgTouchIDAndPasscodeNotSet      :   String  =   "Please set passcode or touchid."

//MARK:-
public let kImgPlaceHolder  :   String  =   "Main_PlaceHolder"

//MARK:- STORY BOARD NAMES
public let SB_MAIN              :   String  =   "Main"
public let SB_Login             :   String  =   "Login"
public let SB_EXTRA             :   String  =   "Extra"

//MARK:- View Controller
public let idLoginVC                :   String  =   "LoginVC"
public let idSignupVC               :   String  =   "SignupVC"
public let idVerifyVC               :   String  =   "VerifyVC"
public let idForgotPasswordVC       :   String  =   "ForgotPasswordVC"
public let idNewPasswordVC          :   String  =   "NewPasswordVC"
public let idUpdateprofileVC        :   String  =   "UpdateprofileVC"
public let idCompliteProfileVC      :   String  =   "CompliteProfileVC"
public let idChangePasswordVC       :   String  =   "ChangePasswordVC"


public let idDashboardVC            :   String  =   "DashboardVC"
public let idHomeVC                 :   String  =   "HomeVC"
public let idMessageVC              :   String  =   "MessageVC"
public let idHomeGalleryImagesVC    :   String  =   "HomeGalleryImagesVC"
public let idHomeGalleryVideoVC     :   String  =   "HomeGalleryVideoVC"
public let idHomeBlogVC             :   String  =   "HomeBlogVC"
public let idUploadVC               :   String  =   "UploadVC"
public let idHomeFilterVC           :   String  =   "HomeFilterVC"
public let idLikeDislikePopupVC     :   String  =   "LikeDislikePopupVC"
public let idMenuVC                 :   String  =   "MenuVC"
public let idSettingsVC             :   String  =   "SettingsVC"
public let idSearchVC               :   String  =   "SearchVC"
public let idProfileVC              :   String  =   "ProfileVC"
public let idRequestsVC             :   String  =   "RequestsVC"
public let idPrivacyVC              :   String  =   "PrivacyVC"
public let idNotificationVC         :   String  =   "NotificationVC"
public let idChatVC                 :   String  =   "ChatVC"


public let idPostVisibleTypePopupVC :   String  =   "PostVisibleTypePopupVC"
public let idReportVC               :   String  =   "ReportVC"
public let idPostImageVC            :   String  =   "PostImageVC"
public let idAddStoryVC             :   String  =   "AddStoryVC"
public let idVideoEditVC            :   String  =   "VideoEditVC"
public let idRecordingWarningVC     :   String  =   "RecordingWarningVC"
