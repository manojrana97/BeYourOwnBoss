//
//  ExpensesViewController.swift
//  BYOB
//
//  Created by manoj on 17/03/20.
//  Copyright © 2020 byob. All rights reserved.
//

import UIKit

class ExpensesViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var expensesTableView: UITableView!
    
    //MARK:- Variables
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK:- Private Functions
    
    //MARK:- IBActions

}

//MARK:- TableView Delegate and DataSource

extension ExpensesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
