//
//  CategoryCollectionViewCell.swift
//  BYOB
//
//  Created by manoj on 17/03/20.
//  Copyright © 2020 byob. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var categoryImageView: UIImageView!
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var selectedImageView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCategoryDetails(category:Category){
        categoryImageView.image = category.categoryImage
        categoryLabel.text = category.name
        selectedImageView.isHidden = category.isSelected ?? false ? false : true
    }

}
