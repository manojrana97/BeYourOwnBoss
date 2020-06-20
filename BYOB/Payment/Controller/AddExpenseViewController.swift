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
    private var newExpense = Expense()
    let db = Firestore.firestore()
    private var selectedCategory:Category?
    private var selectedIndex:Int = 0
    private var inputValidation : InputValidations!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        inputValidation = InputValidations(presentOn: self)
        dateTextField.inputView = datePicker
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        categoryCollectionView.selectItem(at: IndexPath(item: selectedIndex, section: 0), animated: false, scrollPosition: .centeredVertically)
        
    }
    
    //MARK:- IBActions
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        self.db.collection("expenses").document(userId).setData(["expense":[newExpense]], completion: { (error) in
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
            "expense": FieldValue.arrayUnion([newExpense])
        ])
        completion()
    }
    
    //MARK:- Validation Methods
    private func checkInputValidations() -> Bool {
        if inputValidation.isTitleValid(title: titleTextField.text!) &&
            inputValidation.isAmountValid(amount: amountTextField.text ?? "") &&
            inputValidation.isCategoryValid(category: selectedCategory){
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
        categoriesCell.setCategoryDetails(category: User.categoriesAvailable[indexPath.row])
        return categoriesCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndex != indexPath.row{
            User.categoriesAvailable[selectedIndex].isSelected = false
            User.categoriesAvailable[indexPath.row].isSelected = true
            selectedCategory = User.categoriesAvailable[indexPath.row]
            selectedIndex = indexPath.row
            newExpense.category = selectedCategory
            collectionView.reloadData()
        }
        
    }
    
}

//MARK:- TextField Delegates
extension AddExpenseViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == titleTextField{
            newExpense.name = textField.text!
        }else if textField == amountTextField{
            newExpense.amount = Int(textField.text!) ?? 0
        }else if textField == dateTextField {
            textField.text = "\(datePicker.date)"
            newExpense.date = textField.text!
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
