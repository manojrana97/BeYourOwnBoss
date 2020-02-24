//
//
// InputValidations.swift
// DayPlay
//
// Oragnizstion: zapbuild
// Created By: zapbuild on 19/07/19
// Swift Version: 5.0
//Copyright © 2019 zapbuild. All rights reserved.
//Developer Instructions:
//    1.Set access identifier on all functions and properties.
//    2.Keep all properties, functions and outlets private those are not accessible outside of this file.
//     2.Add comment on function using the format /** your comment*/
//
//
        

import Foundation
import UIKit

class InputValidations{
    
    class func                checkCreateLeadValidations(name:String,email:String,mobileNumber:String,category:String,visitDateTime:String,presentationController:UIViewController)->Bool{
        if isFirstNameValid(fname: name, presentationController: presentationController) && isEmailValid(email: email, presentationController: presentationController) && isMobileNumberValid(mobile: mobileNumber, presentationController: presentationController) && isCategoryValid(category: category, presentationController: presentationController) && isDateTimeValid(dateTime: visitDateTime, presentationController: presentationController){
            return true
        }
        return false
    }
    
    class func                checkSignupValidations(fname:String,lname:String,email:String,mobileNumber:String,password:String,companyName:String,reraNumber:String,presentationController:UIViewController)->Bool{
        if isFirstNameValid(fname: fname, presentationController: presentationController) && isLastNameValid(lname: lname, presentationController: presentationController) && isEmailValid(email: email, presentationController: presentationController) && isMobileNumberValid(mobile: mobileNumber, presentationController: presentationController) && isPasswordValid(password: password, presentationController: presentationController) && isCompanyNameValid(company: companyName, presentationController: presentationController) && isReraValid(rera: reraNumber, presentationController: presentationController){
            return true
        }
        return false
    }
    
    class func                checkEditProfileValidations(fname:String,lname:String,mobileNumber:String,presentationController:UIViewController)->Bool{
        if isFirstNameValid(fname: fname, presentationController: presentationController) && isLastNameValid(lname: lname, presentationController: presentationController) && isMobileNumberValid(mobile: mobileNumber, presentationController: presentationController){
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
    
    class func isFirstNameValid(fname:String,presentationController:UIViewController)-> Bool{
        if fname == ""{
            AlertUtility.showAlert(presentationController, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterFirstName)
            return false
        }
        return true
    }
    class func isLastNameValid(lname:String,presentationController:UIViewController)->Bool{
        if lname == ""{
            AlertUtility.showAlert(presentationController, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterLastName)
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
    class func isCompanyNameValid(company:String,presentationController:UIViewController)->Bool{
        if company == ""{
            AlertUtility.showAlert(presentationController, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterCompanyName)
            return false
        }
        return true
    }
    
    class func isReraValid(rera:String,presentationController:UIViewController)->Bool{
        if rera == ""{
            AlertUtility.showAlert(presentationController, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterRera)
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
