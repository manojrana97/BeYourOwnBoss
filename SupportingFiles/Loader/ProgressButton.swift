//
//  ProgressButton.swift
//  Tokr
//
//  Created by Uday on 01/03/19.
//  Copyright © 2019 Zapbuild. All rights reserved.
//

import Foundation
import UIKit

/**
 A simple UIButton subclass with inbuilt activity indicator to show loading or task in progress.
 
 - **Properties**
   - progressColor - Determines the color of activity indicator. Default is white.
        Can be changed from storyboard. Property is IBInspectable.
   - style - enum representing UIActivityIndicatorStyle. Default is .white
   - isAnimating - Returns true|false. True when inidicator is animating.
 
 - **Methods**
   - startAnimating() - Disables user interaction and shows activity indicator.
   - stopAnimating() - Enables user interaction and hides activity indicator.
   - set(enabled: Bool) - Enables the user interaction of button and changes the alpha but don't show/hide activity indicator.
 
 + Important:
 Keep in mind to show/hide indicator on the main thread.
 
 - Note:
 When loader is animating, alpha of button is set to 0.5 to give a fade out effect.
 
 - Authors:
 Uday Bhateja
 
 - Copyright:
 Zapbuild Technologies Pvt Ltd
 
 - Date:
 01/03/2019
 
 - Version:
 1.1
 */
class ProgressButton: UIButton {
    
    //MARK:- Properties
    @IBInspectable var progressColor: UIColor = .white {
        didSet {
            activityIndicator.color = progressColor
        }
    }
    
    var style: UIActivityIndicatorView.Style = .white {
        didSet {
            activityIndicator.style = style
        }
    }
    
    var isAnimating: Bool {
        return !isUserInteractionEnabled
    }
    
    private var activityIndicator   : UIActivityIndicatorView!
    private var buttonText          : String?
    
    //MARK:- init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        activityIndicator = UIActivityIndicatorView(style: style)
        addActivityIndicator()
    }
    
    //MARK:- Private Methods
    private func addActivityIndicator() {
        activityIndicator.alpha = 1.0
        activityIndicator.hidesWhenStopped = true
        
        addSubview(activityIndicator)
        bringSubviewToFront(activityIndicator)
    }
    
    //MARK:- Public functions
    
    /**
     Shows Activity Indicator in Button to indicate loading
     
     - parameters:
        - buttonTitle: Sets the title temporarily until animation is true. If title is set animation loader won't be shown.
    */
    func startAnimating(title buttonTitle: String = "") {
        buttonText = title(for: .normal)
        setTitle(buttonTitle, for: .normal)
        isUserInteractionEnabled = false
        
        if buttonTitle.isEmpty {
            activityIndicator.frame = bounds
            activityIndicator.startAnimating()
        }
    }
    
    func stopAnimating() {
        setTitle(buttonText ?? "", for: .normal)
        activityIndicator.stopAnimating()
        isUserInteractionEnabled = true
    }
    
    func set(enabled: Bool) {
        isUserInteractionEnabled = enabled
        backgroundColor = backgroundColor?.withAlphaComponent(enabled ? 1.0 : 0.5)
    }
    
}
