//
//  Constants.swift
//  Hooty
//
//  Created by Sandeep Singh on 16/11/17.
//  Copyright © 2017 Zapbuild. All rights reserved.
//

import Foundation
import UIKit

class Constants: NSObject {
    
    struct ApiVersion {
        static let versionOne  = "v1/"
    }
    
    enum BaseUrl : String {
        case CI = "http://192.168.1.116/cp67-admin/"
        case devLatest = "http://cp67-admin.zapbuild.in/"
        case new = "http://192.168.1.116/cp67-ci/cp67-admin/"
        case live = "http://cpsuperlogin.cp67.co.in/"
        //case local = "http://192.168.1.117/cp67-ciApi/cp67-admin/"
        case local = "http://192.168.1.117/cp67-admin/"
    }
    
    struct WebServicesApi {
        static let baseUrl = BaseUrl.devLatest.rawValue
        static let signup = Constants.WebServicesApi.baseUrl + "user/register"
        static let login = Constants.WebServicesApi.baseUrl + "user/login"
        static let category = Constants.WebServicesApi.baseUrl + "categories"
        static let forgotPassword = Constants.WebServicesApi.baseUrl + "reset-password"
        static let getLeads = Constants.WebServicesApi.baseUrl + "leads"
        static let getInventory = Constants.WebServicesApi.baseUrl + "all_inventories"
        static let updateStatus = Constants.WebServicesApi.baseUrl + "update/inventories"
        static let logout = Constants.WebServicesApi.baseUrl + "user/logout/"
        static let createLead = Constants.WebServicesApi.baseUrl + "create/lead"
        static let updateLead = Constants.WebServicesApi.baseUrl + "updateLead"
        static let editProfile = Constants.WebServicesApi.baseUrl + "profile/edit"
        static let viewProfile = Constants.WebServicesApi.baseUrl + "profile"
        static let getClientList = Constants.WebServicesApi.baseUrl + "clients"
        static let checkEmail = Constants.WebServicesApi.baseUrl + "email-exist"
        static let getRewards = Constants.WebServicesApi.baseUrl + "rewards"
        static let postRewardPoints = Constants.WebServicesApi.baseUrl + "userRewards"
        static let getNewsFeed = Constants.WebServicesApi.baseUrl + "newsFeeds"
        static let clientListDocumentUrl = Constants.WebServicesApi.baseUrl + "exportClients"
        static let rewardsHistory = Constants.WebServicesApi.baseUrl + "user_rewards_history"
        static let shareNewsFeed = Constants.WebServicesApi.baseUrl + "userNewsRewards"
        static let changePassword = Constants.WebServicesApi.baseUrl + "user/change_password"
        static let getPaymentDetails = Constants.WebServicesApi.baseUrl + "payU_payment_details"
        static let sendPaymentDetail = Constants.WebServicesApi.baseUrl + "payU_hash_list"
        static let matchHashValues = Constants.WebServicesApi.baseUrl + "match_PayUsent_Hash"
    }
    
    struct DateFormats {
        static let ApiDateFormat = "yyyy-MM-dd HH:mm:ssZ"
        static let monthYear = "MMMM yyyy"
        static let responseDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        static let DatePickerDateFormat = "yyyy-MM-dd HH:mm:ssZ"
        static let dateMonthYear = "dd/MM/yyyy"
        static let yearMonthDate = "yyyy-MM-dd"
        static let monthDateYear = "MM-dd-yyyy"
        static let time = "hh:mm a"
        static let chatDateFormat = "yyyy-MM-dd'T'HH:mm:ss.sss'Z'"
        static let messageCellDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        static let apiDate = "yyyy-MM-dd HH:mm:ss"
        static let showLeadDate = "dd/MM/yyyy hh:mm a"
        static let leadListFormat = "dd/MM/yyyy"
        static let formatForHomeLeads = "dd/MM/yyyy 'at' hh:mm a"
    }
    
    
    struct NibFileNames{
        static let leadsCell = "LeadsTableViewCell"
        static let latestCell = "LatestNewsTableViewCell"
        static let clientTableViewCell = "ClientTableViewCell"
        static let newsFeedCell = "NewsTableViewCell"
        static let leadsCollectionCell = "LeadsCollectionViewCell"
        static let rewardTableViewCell = "RewardsTableViewCell"
    }
    
    struct SegueIdentifier {
        static let forgot = "forgotPassword"
        static let categoryView = "categoryView"
        static let editLead = "editLead"
        static let clientList = "clientList"
        static let shareView = "shareFacebook"
        static let editProfile = "EditProfile" 
        static let addLead = "AddLead"
        static let customAlert = "CustomAlert"
        static let staticPages = "StaticPages"
        static let feedDetails = "feedDetails"
        static let changePassword = "changePassword"
    }
    
    struct CellIdentifer{
        static let categoryCell = "categoryCell"
        static let leadsCell = "leadsCell"
        static let settingsCell = "settingsCell"
        static let latestCell = "LatestCell"
        static let clientCell = "clientCell"
        static let newsFeedCell = "newsCell"
        static let leadsCollectionCell = "leadsCollectionCell"
        static let rewardCell = "rewardCell"
    }
    
    struct Pagination{
        static let limit = 10
    }
    
    struct AlertTitle{
        static let success = "Success"
        static let congratulation = "Congratulations"
        static let alert = "Alert"
        static let error = "Error"
        static let permisionDenied = "Permission Denied"
        static let permissionGrantMessage = "Please grant permission in Settings to continue using this service"
        static let noInternet = "No Internet Connection"
    }
    
    struct UserDefaultsKeys{
        static let isUserLogIn = "isUserlogin"
        static let accessToken  = "token"
        static let userId = "userId"
        static let user = "user"
        static let isSocialLogin = "isSocialLogin"
        static let isGuideScreen = "isGuideScreen"
    }
    
    struct StaticUrls {
        static let aboutUs = "http://www.cp67.co.in/home/about-us/"
        static let terms = "http://www.cp67.co.in/terms-of-use/"
        static let privacy = "http://www.cp67.co.in/privacy-policy/"
    }
    
    struct TabBar{
        static let home = 0
        static let newsFeed = 1
        static let profile = 2
        static let settings = 3
    }
    
    struct RegularExpression{
        static let name = #"^[a-zA-Z ]+$"#
        static let phone = #"^[0-9]+$"#
    }
    
    struct InputLengthConstraints {
        struct Minimum {
            static let phoneNumber = 10
            static let username = 8
            static let password = 6
        }
        struct Maximum {
            static let username = 16
            static let email = 30
            static let phoneNumber = 10
            static let name = 50
            static let password = 20
            static let bio = 300
        }
    }
    
    struct ViewControllerNames {
        static let DropDownListViewControllerIdentifier = "DropDownListViewController"
        static let categoryViewControllerIdentifier = "CategoryViewController"
        static let clientListViewController = "ClientListViewController"
        static let editProfileViewController = "EditProfileViewController"
        static let shareFacebookViewController = "ShareFacebookViewController"
        static let inventoryListViewController = "InventoryListViewController"
        static let feedDetails = "feedDetails"
        static let customAlert = "CustomAlert"
        static let paymentOptionViewController = "PaymentOptionViewController"
        static let thankYouAlert = "CustomAlertViewController"
    }
    
    struct ValidationMessages {
        static let noInternetConnection = "Error! Connection Lost while Constructing this Screen"
        static let enterPhoneNumber = "Please enter the phone number"
        static let enterFirstName = "Please enter the first name"
        static let enterLastName = "Please enter the last name"
        static let enterEmail = "Please enter the email address"
        static let enterPassword = "Please enter password"
        static let enterDateTime = "Please select a date & time"
        static let enterCategory = "Please choose a category"
        static let enterCompanyName = "Please enter Company name"
        static let enterRera = "Please enter RERA Number"
        static let enterValidEmail = "Please enter a valid email address"
        static let enterValidUsername = "Please enter a valid username"
        static let passwordNotMatched = "Passwords doesn't matched"
        static let enterValidPassword = "Please enter a valid password"
        static let enterValidPhone = "Please enter a valid phone number"
        static let selectFromDropdown = "Please select a value from the dropdown"
        static let emptyMessage = "Please fill empty fields"
        static let userExist = "User already exist"
        static let errorInFacebookLogin = "Unable to link with Facebook, please try later"
        static let leadUpdateSuccess = "Lead Updated Successfully"
        static let loginFieldsEmpty = "Please enter correct\n Email/Password"
        static let logoutConfirmation = "Are you sure you want to logout?"
        static let profileUpdated = "Profile Updated Successfully"
        static let leadCreateSuccess = "Lead Created Successfully"
        static let saveChanges = "Do you want to save changes?"
        static let shareMessage = "reward points, you can check in profile section."
        static let paymentFailed = "Payment Failed Kindly use another payment option or try after sometime"
    }
    
    struct ValidationRules {
        static let passwordRequirements = "The password cannot be less than 6 characters"
        static let firstNameMinimumLength = "First name should contain atleast 2 characters"
        static let lastNameMinimumLength = "Last name should contain atleast 2 characters"
        static let minimumPhoneLength = "Phone number should be 10 digits"
        static let usernameRequirements = "The username cannot be less than 8 characters\nPlease enter a value more than 8 characters"
    }
    
    struct SuccessMessages{
        static let mailSentSuccess = "Reset password link is send to your email"
        static let passwordChanged = "Your Password has been changed successfully"
        static let signedUpSuccessfully = "Your account will be verified within 24 hours."
        static let profileUpdateSuccess = "Profile Updated Successfully"
    }
    
    struct StatusCode{
        static let success = 200
        static let tokenExpire = 401
    }
    
    enum Storyboard:String {
        case signUp = "SignUp"
        case login = "LoginSignup"
        case home = "Home"
        case more = "More"
        case search = "Search"
        case publicProfile = "PublicProfile"
        case calendar = "Calendar"
        case guideScreen = "GuideScreens"
        case marketPlace = "MarketPlace"
        case messaging = "Messaging"
        case favourites = "Favourites"
    }
    
    enum SocialProvider: String{
        case facebook = "facebook"
        case google = "google"
    }
    
    enum ApplicationNetworkErrorCodes:Int {
        case stateRestriction = 499
    }
    
    struct SocialLoginKeys{
       static let google = "494484808289-33ng19ptvs83qoq2jlh5ncvkpns3r6dc.apps.googleusercontent.com"
    }
    struct ParallaxHeaderAtrributes{
        static let headerHeight:CGFloat = 250.0
    }
    struct NibAttributes{
        static let parallaxHeaderHeight:CGFloat = 250.0
        static let searchFilterViewHeight:CGFloat = 165.0
        
    }
    
    struct AlertButton{
        struct CancelButton{
            static let index = -1
        }
    }
    struct PhotoLibraryAuthorization {
        struct Granted{
            static let rawValue = 3
        }
    }
    
    struct ButtonTitle{
        static let settingsButton = "Open Settings"
        static let cameraButton = "Open Camera"
        static let photoLibraryButton = "Open Photos"
    }
    
    struct DefaultImages {
        static let profilePlaceholderImage = "viewProfilePlaceholder"
        static let noImageAvailable = "no-image"
        
    }
    
    struct AppColours{
        //static let themeColor:UIColor = UIColor.colorWith(hexValue: 0x2D4159)
        //static let themeSelectionColor:UIColor = UIColor.colorWith(hexValue: 0xBD9F52)
    }
    
    struct AppFontNames{
        static let montserratBold = "Montserrat-Bold"
        static let montserratLight = "Montserrat-Light"
        static let montserratMedium = "Montserrat-Medium"
        static let montserratRegular = "Montserrat-Regular"
        static let montserratSemibold = "Montserrat-SemiBold"
    }
    
}




