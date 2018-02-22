//
//  ReviewsProvider.swift
//  SRS
//
//  Created by Andrii Kharchyshyn on 2/13/18.
//  Copyright © 2018 Andrii Kharchyshyn. All rights reserved.
//

import Foundation
import RealmSwift

protocol ReviewsProviderDelegate: class {
    func reviewItemsUpdate(items: [ReviewItem])
}

protocol ReviewsProvider {
    weak var delegate: ReviewsProviderDelegate? { set get }
    func addNewReviewItem(reviewItem: ReviewItem)
    func scheduleNextReviewForItem(reviewItem: ReviewItem)
}

class RealmReviewsProvider: ReviewsProvider {
    
    weak var delegate: ReviewsProviderDelegate?
    
    private let realm: Realm
    private static var avilableReviewsPredicate: NSPredicate {
        return  NSPredicate(format: "nextReviewDate < %@", NSDate())
    }
    private var refreshTimer: Timer!
    private var delegateTriigeredAtLeastOnce = false
    
    var items: Results<ReviewItem> {
        didSet {
            fireDelegate(items: self.items)
        }
    }
    
    func addNewReviewItem(reviewItem: ReviewItem) {
        try? realm.write {
            realm.add(reviewItem)
        }
    }
    
    func scheduleNextReviewForItem(reviewItem: ReviewItem) {
        try? realm.write {
            reviewItem.scheduleNextReview()
        }
        refresh()
    }
    
    init() {
        let reviewSyncConfig = SyncConfiguration(user: SyncUser.current!, realmURL: Constants.REALM_URL)
        let reviewRealm = try! Realm(configuration: Realm.Configuration(syncConfiguration: reviewSyncConfig, objectTypes: [ReviewItem.self]))
        
        self.realm = reviewRealm
        self.items = realm.objects(ReviewItem.self).filter(RealmReviewsProvider.avilableReviewsPredicate)
        self.refreshTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: { (_) in
            self.refresh()
        })
        
    }
    
    
    @objc func refresh() {
        let newItems = realm.objects(ReviewItem.self).filter(RealmReviewsProvider.avilableReviewsPredicate)
        self.items = newItems
    }
    
    private func fireDelegate(items: Results<ReviewItem>) {
        delegateTriigeredAtLeastOnce = true
        delegate?.reviewItemsUpdate(items: items.map({ $0 }))
    }
    
}
