//
//  ExpensesViewController.swift
//  BYOB
//
//  Created by manoj on 17/03/20.
//  Copyright © 2020 byob. All rights reserved.
//

import UIKit
import FirebaseFirestore
import ObjectMapper

class ExpensesViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var expensesTableView: UITableView!
    
    //MARK:- Variables
    private var expenses:[Expense] = []
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK:- Private Functions
    private func getUserData(){
        let db = Firestore.firestore()
        let docRef = db.collection("expenses").document(User.shared.uid!)
        
        docRef.getDocument { (document, error) in
            if let document = document,document.exists{
                if let dataDescription = document.data() {
                    print(dataDescription)
                    self.parseJSON(json: dataDescription)
                }
            }
        }
    }
    
    func parseJSON(json:Any){
        let loggedInUser = Mapper<User>().map(JSON: json as! [String : Any])
        
    }
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
