//
//  CommonUtilities.swift
//  Tokr
//
//  Created by parvinderjit on 06/09/16.
//  Copyright © 2016 Zapbuild. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC
import Security
import CoreLocation
import MapKit


class CommonUtilities {
    
    
//    class func setupSearchBar(searchBar:UISearchBar) {
//          if let textField = searchBar.value(forKey: "searchField") as? UITextField {
//              textField.borderStyle = .none
//              textField.backgroundColor = .white
//              textField.layer.cornerRadius = 18
//              textField.layer.masksToBounds = true
//              textField.borderWidth = 0.8
//              textField.borderColor = UIColor.darkGray //#a5aaad
//              textField.leftView?.contentMode = .scaleAspectFit
//              var frame = textField.leftView?.frame
//              frame?.size.width += 10
//              textField.leftView?.frame = frame!
//              textField.clearButtonMode = .never
//              textField.textColor = UIColor.themeBlueColor() //#475468
//              textField.clearButtonMode = .whileEditing
//              searchBar.returnKeyType = .default
//          }
//      }
    
    class func getUserFromUserDefaults() -> User? {
        if let user = UserDefaultManager.sharedManager.objectForKey(key:Constants.UserDefaultsKeys.user) {
            return NSKeyedUnarchiver.unarchiveObject(with: user as! Data) as? User
        }
        return nil
    }
    
    //MARK:- Date Functions
    class func changedateFormat(date: String, format: String,actualFormat: String =  Constants.DateFormats.ApiDateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = actualFormat
        dateFormatter.locale = .current
        guard let date = dateFormatter.date(from: date) else {
            return "0000-00-00 00:00:00"
        }
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    class func toDate(withFormat format: String = "yyyy-MM-dd", string: String)-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: string)
        return date
        
    }
    
    class func dateToString(date: Date, format:String) ->  String{
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = format 
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd
    }
    
    class func getTodayDate()->Date{
        let date = Date()
        let toDayDate = Calendar.current.dateComponents(in: .current, from: date).date!
        return toDayDate
    }
    
    class func getMaxDate()->Date{
       let maxDate = Calendar.current.date(byAdding: .month, value: 6, to: self.getTodayDate())!
        return maxDate
    }
    
    class func getMinimumDate()-> Date{
        let minDate = Calendar.current.date(byAdding: .month, value: -3, to: self.getTodayDate())!
        return minDate
    }
    
    class func getDatesBetweenInterval(_ startDate: Date, _ endDate: Date) -> [Date] {
        var startDate = startDate
        let calendar = Calendar.current
        let fmt = DateFormatter()
        fmt.dateFormat = Constants.DateFormats.yearMonthDate
        var dateArray: [Date] = []
        while startDate <= endDate {
            dateArray.append(startDate)
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        }
        return dateArray
    }
    
    class func compareDate(date: Date, todayDate: Date) -> ComparisonResult {
        return date.compare(todayDate)
    }
    
    class func differenceBetweenTwoDates(laterDate:Date, earlierDate:Date) -> Int{
        return Int(laterDate.timeIntervalSince(earlierDate))
    }
    
    class func unixToTimezoneFormat(dateInDouble:Double, dateFormat: String)-> String{
        let date = Date(timeIntervalSince1970: dateInDouble)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+5:30") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = dateFormat //Specify your format that you want
        let convertedDate = dateFormatter.string(from: date)
        return convertedDate
    }
    
    class func currentTimeInMiliseconds() -> Double! {
        let currentDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormats.yearMonthDate
        //dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let date = dateFormatter.date(from: dateFormatter.string(from: currentDate as Date))
        let nowDouble = date!.timeIntervalSince1970
        return Double(nowDouble)
    }
    
    class func timeAgoSinceDate(date:NSDate) -> String? {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest as Date, to: latest as Date)
        
        if components.day! > 1 {
            return CommonUtilities.dateToString(date: date as Date, format: Constants.DateFormats.dateMonthYear)
        }
//        else if components.day! == 1 {
//            return "Yesterday"
//        }
        else {
            return CommonUtilities.dateToString(date: date as Date, format: "hh:mm a")
        }

    }
    
    class func timeSinceDate(_ date:Date, numericDates:Bool = false) -> String? {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        if (components.year! >= 2) {
            return "\(components.year!)yr"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1yr"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!)mo"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 mo"
            } else {
                return "Last mo"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 d"
            } else {
//                return "1 d"
                return "yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hrs"
        } else if (components.hour! >= 1){
            if (numericDates){
//                return "1 hr"
                 return CommonUtilities.dateToString(date: date as Date, format: "hh:mm a")
            } else {
//                return "1 hr"
                 return CommonUtilities.dateToString(date: date as Date, format: "hh:mm a")
            }
        } else if (components.minute! >= 2) {
//            return "\(components.minute!) m"
             return CommonUtilities.dateToString(date: date as Date, format: "hh:mm a")
        } else if (components.minute! >= 1){
            if (numericDates){
//                return "1 m"
                 return CommonUtilities.dateToString(date: date as Date, format: "hh:mm a")
            } else {
//                return "2 m"
                 return CommonUtilities.dateToString(date: date as Date, format: "hh:mm a")
            }
        } else if (components.second! >= 3) {
//            return "\(components.second!)s"
             return CommonUtilities.dateToString(date: date as Date, format: "hh:mm a")
        } else {
//            return "now"
             return CommonUtilities.dateToString(date: date as Date, format: "hh:mm a")
        }
        
    }
    
    //MARK:- String to Json Dictionary Conversion
    class func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    //MARK:- PasswordShowHide Method
    class func showHidePasswordCharacters(textField:UITextField, button:UIButton){
        //Tag 0 for uncrossed state
        //Tag 1 for crossed state
        
        let isShowPassword = Bool(truncating: button.tag as NSNumber)
        textField.isSecureTextEntry = isShowPassword
        let eyeIcon = isShowPassword ? UIImage(named: "system.eye") : UIImage(named: "system.eyeslash")
        button.setImage(eyeIcon, for: .normal)
        button.tag = isShowPassword ? 0 : 1
    }
    
    //MARK:- OpenAppSettings Method
    class func openAppSettings(){
        if let url = URL(string:UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
  
  class Loader{
    
        class func showProgressBar(_ msg:String){
            var loaderConfiguration = SwiftLoader.Config()
            loaderConfiguration.size = 100
            //loaderConfiguration.backgroundColor = UIColor.colorWith(hexValue: 0x3C3C3C)
            loaderConfiguration.spinnerColor = UIColor.white
            loaderConfiguration.titleTextColor = UIColor.white
            loaderConfiguration.spinnerLineWidth = 1.0
            loaderConfiguration.foregroundColor = UIColor.black
            loaderConfiguration.foregroundAlpha = 0.5
            SwiftLoader.setConfig(config: loaderConfiguration)
            SwiftLoader.show(title: msg, animated: true)
        }
    
        class func hideProgressBar() {
            SwiftLoader.hide()
        }
    
  }
  
    class func openImdbLink(imdb:String,toastController:UIViewController){
        if imdb == ""{
            ToastUtility.showToast(message: "No IMDB Link available for this user", controller: toastController)
        }else{
            if !(imdb.hasPrefix("https://")) {
                UIApplication.shared.open(URL(string: "https://\(imdb)")!)
            }else{
                UIApplication.shared.open(URL(string: imdb)!)
            }
            
        }
    }
    
    class func changeButtonState(button:UIButton,title:String,titleColor:UIColor,image:UIImage,BackgroundColor:UIColor){
        button.setTitle(title, for: .normal)
        button.backgroundColor = BackgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.setImage(image, for: .normal)
    }
 
}

open class FormValidation {
    
    class func checkValidEmail(_ email:String) -> Bool {
        let emailRegEx = "^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    class func checkValidPhone(_ phone:String)-> Bool{
        let PHONE_REGEX = "^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[0-9]*$"
        return NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX).evaluate(with: phone)
    }
    
}


class AlertUtility {
    
    static let CancelButtonIndex = -1;
    
    class func showAlert(_ onController:UIViewController!, title:String?,message:String? ) {
        showAlert(onController, title: title, message: message, cancelButton: "OK", buttons: nil, actions: nil)
    }
    
    /**
     - parameter title:        title for the alert
     - parameter message:      message for alert
     - parameter cancelButton: title for cancel button
     - parameter buttons:      array of string for title for other buttons
     - parameter actions:      action is the callback which return the action and index of the button which was pressed
     */
    
    
    class func showAlert(_ onController:UIViewController!, title:String?,message:String? = nil ,cancelButton:String = "OK",buttons:[String]? = nil,actions:((_ alertAction:UIAlertAction,_ index:Int)->())? = nil) {
        // make sure it would be run on  main queue
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: cancelButton, style: UIAlertAction.Style.cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
            actions?(action,CancelButtonIndex)
        }
        alertController.addAction(action)
        if let _buttons = buttons {
            for button in _buttons {
                let action = UIAlertAction(title: button, style: .default) { (action) in
                    let index = _buttons.index(of: action.title!)
                    actions?(action,index!)
                }
                alertController.addAction(action)
            }
        }
        onController.present(alertController, animated: true, completion: nil)
    }
}

class ToastUtility{
    
    class func showToast(message : String, controller: UIViewController) {
        let toastLabel = UILabel(frame: CGRect(x: controller.view.frame.size.width/2 - 150, y: controller.view.frame.size.height - 150, width: 300, height: 35))
        //toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 5;
        toastLabel.clipsToBounds  =  true
        controller.view.addSubview(toastLabel)
        controller.view.bringSubviewToFront(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
  
}



