//
//  ClosureButton
//  Tokr
//
//  Created by parvinderjit on 12/09/16.
//  Copyright © 2016 Zapbuild. All rights reserved.
//

import Foundation
import UIKit

protocol ClosureButtonTargetViewDelegate:class {
    func closureButtonTargetView() -> UIView!
}

class ClosureButton: UIButton {
    
    public typealias ButtonAction = (ClosureButton)->Void
    private var closureCallback:ButtonAction!
    
    var targetViewDelegate:ClosureButtonTargetViewDelegate!
    
    func setAction(controlEvents:UIControl.Event = UIControl.Event.touchUpInside,action:@escaping ButtonAction){
        self.closureCallback = action
        self.removeTarget(self, action: #selector(ClosureButton.actionPerformed), for: controlEvents)
        self.addTarget(self, action: #selector(ClosureButton.actionPerformed), for: controlEvents)
    }
   
    @objc private func actionPerformed() {
        self.closureCallback(self)
    }
    
    var targetView:UIView {
        get{
            if let view = targetViewDelegate.closureButtonTargetView() {
                return view
            }
            fatalError("implement the ClosureButtonTargetViewDelegate to the target view")
        }
    }
    
}
