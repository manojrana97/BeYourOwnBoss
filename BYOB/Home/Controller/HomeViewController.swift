//
//  HomeViewController.swift
//  BYOB
//
//  Created by manoj on 09/03/20.
//  Copyright © 2020 byob. All rights reserved.
//

import UIKit
import FirebaseFirestore

class HomeViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak private var segmentControl:UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegementView()
        setContainerView(index: 0)
    }
    
    //MARK:- Private Functions
    private func setSegementView(){
        segmentControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.appMediumFontWith(size: 17),
            NSAttributedString.Key.foregroundColor: UIColor.white
            ], for: .normal)
        
        segmentControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.appMediumFontWith(size: 17),
            NSAttributedString.Key.foregroundColor: UIColor.themeBlueColor()
            ], for: .selected)
    }
    
    private func initViewControllersArray()-> [UIViewController?] {
        
        weak var graphViewController: GraphViewController? = {
            let vc = UIStoryboard(name: Storyboard.home.name, bundle: nil).instantiateViewController(withIdentifier: ViewControllers.graphVC) as? GraphViewController
            return vc
            
    }()
        
        weak var categorisedViewController:CategorizedViewController? = {
            return UIStoryboard(name: Storyboard.home.name, bundle: nil).instantiateViewController(withIdentifier: ViewControllers.categorizedVC) as? CategorizedViewController
        }()
        
        
        return [graphViewController,categorisedViewController]
    }
    
    private func setContainerView(index:Int){
        self.children.first?.view.removeFromSuperview()
        self.children.first?.removeFromParent()
        guard let childViewController = initViewControllersArray()[index] else { return }
        childViewController.view.frame = containerView.bounds
        self.containerView.addSubview(childViewController.view)
        self.addChild(childViewController)
        childViewController.didMove(toParent: self)
    }
    
    
    
    //MARK:- IBActions
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        setContainerView(index:sender.selectedSegmentIndex)
    }
    
    

}
