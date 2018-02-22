//
//  ItemsCell.swift
//  SRS
//
//  Created by Andrii Kharchyshyn on 2/14/18.
//  Copyright © 2018 Andrii Kharchyshyn. All rights reserved.
//

import UIKit

protocol ReviewSetupable {
    func setup(reviewItem: ReviewItem)
}

class ItemsCell: UICollectionViewCell, ReviewSetupable {
    
    @IBOutlet weak var label: UILabel!
    
    func setup(reviewItem: ReviewItem) {
        label.text = reviewItem.kanji
    }
}
