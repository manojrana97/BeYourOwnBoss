//
//  SettingOptionsViewController.swift
//  BYOB
//
//  Created by manoj on 11/03/20.
//  Copyright © 2020 byob. All rights reserved.
//

import UIKit

class SettingOptionsViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak private var settingOptionsTableView:UITableView!
    
    //MARK:- Variables
    let settingOptions:[SettingOption] = [SettingOption(image: #imageLiteral(resourceName: "Logout"), optionName: "Logout")]
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Register a Custom TableViewCell
        settingOptionsTableView.register(UINib(nibName: "SettingOptionsCell", bundle: nil), forCellReuseIdentifier: "SettingOptionsCell")
    }

}

//MARK:- TableView DataSource and Delegates
extension SettingOptionsViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingOptionCell = tableView.dequeueReusableCell(withIdentifier: "SettingOptionsCell") as! SettingOptionsCell
        settingOptionCell.optionImageView.image = settingOptions[indexPath.row].image
        settingOptionCell.optionNameLabel.text = settingOptions[indexPath.row].optionName!
        return settingOptionCell
    }
    
    
}

//MARK:- Setting Option
struct SettingOption {
    var image:UIImage?
    var optionName:String?
}
