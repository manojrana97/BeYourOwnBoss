//
//  CategorizedExpenceCell.swift
//  BYOB
//
//  Created by manoj on 09/03/20.
//  Copyright © 2020 byob. All rights reserved.
//

import UIKit

class CategorizedExpenceCell: UITableViewCell {
    //MARK:- IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var trasactionCountLabel: UILabel!
    @IBOutlet weak var viewTrasactionButton: UIButton!
    
    
    //MARK:- Variables
    var viewTrasactionsButtonHandler : ((Int) -> ())?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK:- IBActions
    @IBAction func viewTrasactionButtonTapped(_ sender: UIButton) {
        viewTrasactionsButtonHandler!(sender.tag)
    }
    
    
}
