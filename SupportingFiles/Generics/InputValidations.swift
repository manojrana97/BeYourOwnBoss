//
// InputValidations.swift
// BYOB
//
// Created By: Manoj Kumar on 05/03/20

        

import Foundation
import UIKit

class InputValidations{
    class func                checkSignupValidations(name:String,email:String,mobileNumber:String,password:String,presentationController:UIViewController)->Bool{
        if isNameValid(name: name, presentationController: presentationController) && isEmailValid(email: email, presentationController: presentationController) && isMobileNumberValid(mobile: mobileNumber, presentationController: presentationController) && isPasswordValid(password: password, presentationController: presentationController) {
            return true
        }
        return false
    }
    
    class func                checkEditProfileValidations(name:String,lname:String,mobileNumber:String,presentationController:UIViewController)->Bool{
        if isNameValid(name: name, presentationController: presentationController) && isMobileNumberValid(mobile: mobileNumber, presentationController: presentationController){
            return true
        }
        return false
    }
    
    class func checkLoginValidations(email:String,password:String,presentationController:UIViewController)->Bool{
        if isEmailValid(email: email, presentationController:presentationController){
            if password != ""{
                return true
            }else{
                AlertUtility.showAlert(presentationController, title: Constants.AlertTitle.error, message: Constants.ValidationMessages.enterPassword)
                return false
            }
        }
        return false
    }
    
    class func isNameValid(name:String,presentationController:UIViewController)-> Bool{
        if name == ""{
            AlertUtility.showAlert(presentationController, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterName)
            return false
        }
        return true
    }
    
    class func isEmailValid(email:String,presentationController:UIViewController)->Bool{
        if email == ""{
            AlertUtility.showAlert(presentationController, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterEmail)
            return false
        }else{
            if FormValidation.checkValidEmail(email){
                return true
            }else{
                AlertUtility.showAlert(presentationController, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterValidEmail)
                return false
            }
        }
        
    }
    
    class func isMobileNumberValid(mobile:String,presentationController:UIViewController)->Bool{
        if mobile == ""{
            AlertUtility.showAlert(presentationController, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterPhoneNumber)
            return false
        }else if mobile.count < Constants.InputLengthConstraints.Minimum.phoneNumber{
            AlertUtility.showAlert(presentationController, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterValidPhone)
            return false
        }else{
            return true
        }
    }
    
    class func isPasswordValid(password:String,presentationController:UIViewController)->Bool{
        if password == ""{
            AlertUtility.showAlert(presentationController, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterPassword)
            return false
        }else if password.count < Constants.InputLengthConstraints.Minimum.password{
            AlertUtility.showAlert(presentationController, title: Constants.AlertTitle.alert, message: Constants.ValidationRules.passwordRequirements)
            return false
        }
        return true
    }
    
    class func isCategoryValid(category:String,presentationController:UIViewController)->Bool{
        if category == ""{
            AlertUtility.showAlert(presentationController, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterCategory)
            return false
        }
        return true
    }
    
    class func isDateTimeValid(dateTime:String,presentationController:UIViewController)->Bool{
        if dateTime == ""{
            AlertUtility.showAlert(presentationController, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterDateTime)
            return false
        }
        return true
    }
}
