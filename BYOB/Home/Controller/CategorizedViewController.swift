//
//  CategorizedViewController.swift
//  BYOB
//
//  Created by manoj on 09/03/20.
//  Copyright © 2020 byob. All rights reserved.
//

import UIKit

class CategorizedViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CategorizedExpenceCell", bundle: nil), forCellReuseIdentifier: "CategorizedExpenceCell")

    }
    
}

//MARK:- UITableView DataSource & Delegates
extension CategorizedViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.categoriesAvailable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoriesCell = tableView.dequeueReusableCell(withIdentifier: "CategorizedExpenceCell") as! CategorizedExpenceCell
        categoriesCell.nameLabel.text = User.categoriesAvailable[indexPath.row].name
        return categoriesCell
    }
    
    
}
