//
//  ReviewItem.swift
//  SRS
//
//  Created by Andrii Kharchyshyn on 2/2/18.
//  Copyright © 2018 Andrii Kharchyshyn. All rights reserved.
//

import Foundation
import RealmSwift
import IGListKit

class ReviewItem: Object {
    
    @objc dynamic var itemId: String = UUID().uuidString
    @objc dynamic var kanji: String = ""
    @objc dynamic var startDate: Date = Date()
    @objc dynamic var nextReviewDate: Date = Date()
    
    override static func primaryKey() -> String? {
        return "itemId"
    }
    
    convenience init(kanji: String) {
        self.init()
        self.kanji = kanji
        self.startDate = Date()
        self.nextReviewDate = Date()
    }
    
    func scheduleNextReview() {
        self.nextReviewDate = Date().addingTimeInterval(7)
    }
    
}

extension ReviewItem: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return kanji as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? ReviewItem else {
            return false
        }
        return self.kanji == object.kanji
    }
    
    
}
