//
//  LabelSectionController.swift
//  SRS
//
//  Created by Andrii Kharchyshyn on 2/8/18.
//  Copyright © 2018 Andrii Kharchyshyn. All rights reserved.
//

import UIKit
import IGListKit

protocol LabelSectionControllerDelegate: class {
    func didSelectItem(reviewItem: ReviewItem)
}

class LabelSectionController: ListSectionController {
    
    var reviewItem: ReviewItem?
    weak var delegate: LabelSectionControllerDelegate?
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 55)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(withNibName: "ItemsCell", bundle: nil, for: self, at: index)
        
        if let cell = cell as? ReviewSetupable, let reviewItem = reviewItem {
            cell.setup(reviewItem: reviewItem)
        }
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        reviewItem = object as? ReviewItem
    }
    
    override func didSelectItem(at index: Int) {
        if let reviewItem = reviewItem {
            delegate?.didSelectItem(reviewItem: reviewItem)
        }
    }
}
