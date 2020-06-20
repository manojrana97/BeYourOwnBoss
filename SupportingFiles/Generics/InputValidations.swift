//
// InputValidations.swift
// BYOB
//
// Created By: Manoj Kumar on 05/03/20

        

import Foundation
import UIKit

class InputValidations{
    //MARK:- Properties
    private var controller:UIViewController?
    
    //MARK:- InitiaLization
    init(presentOn:UIViewController) {
        self.controller = presentOn
    }
    
    func                checkSignupValidations(name:String,email:String,mobileNumber:String,password:String)->Bool{
        if isNameValid(name: name) && isEmailValid(email: email) && isMobileNumberValid(mobile: mobileNumber) && isPasswordValid(password: password) {
            return true
        }
        return false
    }
    
    func                checkEditProfileValidations(name:String,lname:String,mobileNumber:String)->Bool{
        if isNameValid(name: name) && isMobileNumberValid(mobile: mobileNumber){
            return true
        }
        return false
    }
    
    func checkLoginValidations(email:String,password:String)->Bool{
        if isEmailValid(email: email){
            if password != ""{
                return true
            }else{
                AlertUtility.showAlert(self.controller, title: Constants.AlertTitle.error, message: Constants.ValidationMessages.enterPassword)
                return false
            }
        }
        return false
    }
    
    func isNameValid(name:String)-> Bool{
        if name == ""{
            AlertUtility.showAlert(controller, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterName)
            return false
        }
        return true
    }
    
    func isEmailValid(email:String)->Bool{
        if email == ""{
            AlertUtility.showAlert(self.controller, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterEmail)
            return false
        }else{
            if FormValidation.checkValidEmail(email){
                return true
            }else{
                AlertUtility.showAlert(self.controller, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterValidEmail)
                return false
            }
        }
        
    }
    
    func isMobileNumberValid(mobile:String)->Bool{
        if mobile == ""{
            AlertUtility.showAlert(self.controller, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterPhoneNumber)
            return false
        }else if mobile.count < Constants.InputLengthConstraints.Minimum.phoneNumber{
            AlertUtility.showAlert(self.controller, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterValidPhone)
            return false
        }else{
            return true
        }
    }
    
    func isPasswordValid(password:String)->Bool{
        if password == ""{
            AlertUtility.showAlert(self.controller, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterPassword)
            return false
        }else if password.count < Constants.InputLengthConstraints.Minimum.password{
            AlertUtility.showAlert(self.controller, title: Constants.AlertTitle.alert, message: Constants.ValidationRules.passwordRequirements)
            return false
        }
        return true
    }
    
    //MARK:- Expense Attributes Validations
    func isTitleValid(title:String) -> Bool{
        if title == ""{
            AlertUtility.showAlert(self.controller, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterTitle)
            return false
        }
        return true
    }
    
    func isAmountValid(amount:String) -> Bool{
        if amount == ""{
            AlertUtility.showAlert(self.controller, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterAmount)
            return false
        }else if amount == "0"{
            AlertUtility.showAlert(self.controller, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterValidAmount)
            return false
        }
        return true
    }
    
    func isCategoryValid(category:Category?)->Bool{
        if category == nil{
            AlertUtility.showAlert(self.controller, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterCategory)
            return false
        }
        return true
    }
    
    func isDateTimeValid(dateTime:String)->Bool{
        if dateTime == ""{
            AlertUtility.showAlert(self.controller, title: Constants.AlertTitle.alert, message: Constants.ValidationMessages.enterDateTime)
            return false
        }
        return true
    }
}
