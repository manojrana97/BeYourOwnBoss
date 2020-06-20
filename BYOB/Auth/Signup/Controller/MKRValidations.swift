
import Foundation
import UIKit
/**
This Class manages all of your input validations on various input forms throughout the project.
 
- Author:
Manoj Kumar Rana
 
- Copyright:
Manoj Kumar Rana
 
- Date:
04/04/20
 
- Version:
1.1
*/
class MKRValidations:NSObject{
    
    //MARK:- Variables
    private var controller:UIViewController?
    
    //MARK:- Initialization
    init(controller:UIViewController){
        self.controller = controller
    }
    
    //MARK:- Show Alert Method
    private func showAlertWithTitle (title:String, message: String, controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK:- Validation Methods
    func isFirstNameValid(fname:String)-> Bool{
        if fname == ""{
            showAlertWithTitle(title: AlertMessages.Title.alert, message: AlertMessages.Validation.showEmptyField(field:"First name"), controller: controller!)
            return false
        }
        return true
    }
    
    func isLastNameValid(lname:String)->Bool{
        if lname == ""{
            showAlertWithTitle(title: AlertMessages.Title.alert, message: AlertMessages.Validation.showEmptyField(field:"Last name"), controller: controller!)
            return false
        }
        return true
    }
    
    func isEmailValid(email:String)->Bool{
        if email == ""{
            showAlertWithTitle(title: AlertMessages.Title.alert, message: AlertMessages.Validation.showEmptyField(field: "Email"), controller: controller!)
            return false
        }else if !(isValidEmail(emailAddress:email)) {
            showAlertWithTitle(title: AlertMessages.Title.alert, message: AlertMessages.Validation.showInvalidData(field: "Email"), controller: controller!)
            return false
        }else{
            return true
        }
    }
    
    func isMobileNumberValid(mobile:String)->Bool{
        if mobile == ""{
            showAlertWithTitle(title: AlertMessages.Title.alert, message: AlertMessages.Validation.showEmptyField(field:"Mobile Number"), controller: controller!)
            return false
        }else if !(checkValidMobileNumber(phoneNumber: mobile)){
            showAlertWithTitle(title: AlertMessages.Title.alert, message: AlertMessages.Validation.showInvalidData(field: "Mobile Number"), controller: controller!)
            return false
        }else{
            return true
        }
    }
    
    func isCountrycodeValid(code:String)->Bool{
        
        if code == ""{
            showAlertWithTitle(title: AlertMessages.Title.alert, message:AlertMessages.Validation.showEmptyPicker(choose: "Country Code"), controller: controller!)
            return false
        }else{
            if !(checkValidCountryCode(code: code)){
                showAlertWithTitle(title: AlertMessages.Title.alert, message: AlertMessages.Validation.showInvalidData(field: "Country Code"), controller: controller!)
                return false
            }
            
        }
        return true
    }
    func isPasswordValid(password:String)->Bool{
        if password == ""{
            showAlertWithTitle(title: AlertMessages.Title.alert, message: "Please enter Password", controller:controller! )
            return false
        }else if password.count < 6 {
            showAlertWithTitle(title: AlertMessages.Title.alert, message: AlertMessages.Validation.showInvalidData(field: "Password"), controller: controller!)
            
            return false
        }
        return true
    }
    
    func isConfirmPasswordMatched(newPassword:String,confirmPassword:String) -> Bool {
        if confirmPassword == "" {
            showAlertWithTitle(title: AlertMessages.Title.alert, message: AlertMessages.Validation.showEmptyField(field:"Confirm Password"), controller: controller!)
            return false
        }else{
            if newPassword != confirmPassword {
                showAlertWithTitle(title: AlertMessages.Title.alert, message: "Confirm Password doesn't match", controller: controller!)
                return false
            }
        }
        return true
    }
    
    //MARK:- Input Validations
    private func isValidEmail(emailAddress:String) -> Bool {
        let emailRegex = "^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,4})$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: emailAddress)
    }
    
    private func checkValidMobileNumber(phoneNumber:String)-> Bool {
        let PHONE_REGEX = #"^[0-9]{10}$"#
        return NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX).evaluate(with: phoneNumber)
    }
    
    private func checkValidCountryCode(code:String) -> Bool{
        let COUNTRY_REGEX = #"^[+]{0,1}[0-9]{0,1}[-]{0,1}[0-9]{1,3}$"#
        return NSPredicate(format: "SELF MATCHES %@", COUNTRY_REGEX).evaluate(with: code)
    }
}


//MARK:- Empty Message
struct AlertMessages {
    struct Title {
        static let alert = "Alert"
        static let success = "Success"
        static let error = "Error"
    }

    struct Validation {
        static func showEmptyField(field:String) -> String{
            return "Please enter \(field)"
        }

        static func showEmptyPicker(choose:String) -> String{
            return "Please select a \(choose)"
        }

        static func showInvalidData(field:String) -> String{
            return "Please enter a valid \(field)"
        }
    }
}
