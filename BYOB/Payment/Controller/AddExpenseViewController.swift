//
//  AddExpenseViewController.swift
//  BYOB
//
//  Created by manoj on 17/03/20.
//  Copyright © 2020 byob. All rights reserved.
//

import UIKit
import FirebaseFirestore

class AddExpenseViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet var datePicker: UIDatePicker!
    
    //MARK:- Variables
    private var newExpense:Expense?
    let db = Firestore.firestore()
    private var selectedCategory:Category?
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTextField.inputView = datePicker
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        
    }
    
    //MARK:- IBActions
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addExpenseButtonTapped(_ sender: Any) {
        if checkInputValidations() {
            if User.shared.expenseDataBaseSetup! {
                addNewExpense(userID: User.shared.uid) {
                    self.dismiss(animated: true, completion: nil)
                }
            }else{
                setExpencesDataBase(userId: User.shared.uid)
            }
        }
        
    }
    
    //MARK:- Private Functions
    private func setExpencesDataBase(userId:String){
        self.db.collection("expenses").document(userId).setData(["expense":[newExpense!]], completion: { (error) in
            if let _error = error{
                AlertUtility.showAlert(self, title: Constants.AlertTitle.error, message: _error.localizedDescription)
            }else{
                self.db.collection("users").document(userId).setData([ "isExpenseSeted": true ], merge: true)
                User.shared.expenseDataBaseSetup = true
            }})
    }
    
    private func addNewExpense(userID:String, completion:()->()){
        let expenseRef = db.collection("expenses").document(userID)

        expenseRef.updateData([
            "expense": FieldValue.arrayUnion([newExpense!])
        ])
        completion()
    }
    
    //MARK:- Validation Methods
    private func checkInputValidations() -> Bool {
        if InputValidations.isTitleValid(title: titleTextField.text!, presentationController: self) &&
            InputValidations.isAmountValid(amount: amountTextField.text ?? "", presentationController: self) &&
            InputValidations.isCategoryValid(category: selectedCategory, presentationController: self){
            return true
        }
        return false
    }
    
}

//MARK:- CollectionView Delegates and Data Sources
extension AddExpenseViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return User.categoriesAvailable.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        categoriesCell.categoryLabel.text = User.categoriesAvailable[indexPath.row].name!
        categoriesCell.categoryImageView.image = User.categoriesAvailable[indexPath.row].categoryImage!
        return categoriesCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 100)
    
    }
    
    
    
}

//MARK:- TextField Delegates
extension AddExpenseViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == dateTextField {
            textField.text = "\(datePicker.date)"
        }
    }
}

/*
 AlertUtility.showAlert(self, title: Constants.AlertTitle.success, message: "Expense Added Successfully", cancelButton: "OK", buttons: []) { (action, index) in
     if index == -1{
         self.dismiss(animated: true, completion: nil)
     }
 }
 */
