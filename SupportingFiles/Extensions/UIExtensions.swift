//
//  UIViewExtension.swift
//  BYOB
//
//  Created by Manoj Kumar on 20/02/20.
//  Copyright © 2020 byob. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.black.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
          get {
              return UIColor(cgColor: layer.shadowColor ?? UIColor.clear.cgColor)
          }
          set {
              layer.shadowColor = newValue.cgColor
          }
      }
    
    @IBInspectable var shadowOffset: CGSize {
          get {
            return layer.shadowOffset
          }
          set {
              layer.shadowOffset = newValue
          }
      }
    
    @IBInspectable var shadowOpacity: Float {
             get {
               return layer.shadowOpacity
             }
             set {
                 layer.shadowOpacity = newValue
             }
         }
    
    @IBInspectable var shadowRadius: CGFloat {
               get {
                 return layer.shadowRadius
               }
               set {
                   layer.shadowRadius = newValue
               }
           }

    
    /**
     For adding current into a superview with fit at all.
     -parameter:
        -container: View in which current view to be fitted
     */
    func fixInView(_ container: UIView!) -> Void{
               self.translatesAutoresizingMaskIntoConstraints = false;
               self.frame = container.frame;
               container.addSubview(self);
               NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
               NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
               NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
               NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
           }
    
}



extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }
    class func themeBlueColor()->UIColor{
          return UIColor.init(red: 31/255, green: 33/255, blue: 36/255, alpha: 1.0)
      }
    
      
   convenience init(hex: Int) {
       self.init(
           red: (hex >> 16) & 0xFF,
           green: (hex >> 8) & 0xFF,
           blue: hex & 0xFF
       )
   }
}

//MARK:- Font Class Extension
extension UIFont {
    
    class func appRegularFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "Montserrat-Regular", size: size)!
    }
    
    class func appBoldFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "Montserrat-Bold", size: size)!
    }
    
    class func appMediumFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "Montserrat-Medium", size: size)!
    }
    
    class func appLightFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "Montserrat-Light", size: size)!
    }
    
    class func appSemiboldFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "Montserrat-SemiBold", size: size)!
    }
    
}
