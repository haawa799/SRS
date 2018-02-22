//
//  ItemsViewController.swift
//  SRS
//
//  Created by Andrii Kharchyshyn on 2/2/18.
//  Copyright © 2018 Andrii Kharchyshyn. All rights reserved.
//

import UIKit
import IGListKit

class ReviewItemsViewController: UIViewController {
    
    fileprivate var reviewItems = [ReviewItem]()
    private var provider: ReviewsProvider?
    private let collectionView: UICollectionView
    private let updater: ListAdapterUpdater
    private var adapter: ListAdapter!
    private let colorSchema: ColorSchema
    
    
    init(dataprovider: ReviewsProvider, colorSchema: ColorSchema) {
        
        self.colorSchema = colorSchema
        provider = dataprovider
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        updater = ListAdapterUpdater()
        
        super.init(nibName: nil, bundle: nil)
        self.provider?.delegate = self
        
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        
        adapter = ListAdapter(updater: updater, viewController: self)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("init(nibName:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Review items"
        view.addSubview(collectionView)
        collectionView.backgroundColor = colorSchema.backgroundColor
        collectionView.frame = self.view.frame
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonDidClick))
    }
    
    @objc func addButtonDidClick() {
        let alertController = UIAlertController(title: "Add Review Item", message: "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            if let kanji = textField.text {
                let item = ReviewItem(kanji: kanji)
                self.provider?.addNewReviewItem(reviewItem: item)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Kanji"
        })
        self.present(alertController, animated: true, completion: nil)
    }
}




// MARK: - ListAdapterDataSource
extension ReviewItemsViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.reviewItems
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        let sectionController = LabelSectionController()
        sectionController.delegate = self
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let view = UIView()
        view.backgroundColor = colorSchema.backgroundColor
        return view
    }
    
}

// MARK: - ReviewsProviderDelegate
extension ReviewItemsViewController: ReviewsProviderDelegate {
    func reviewItemsUpdate(items: [ReviewItem]) {
        self.reviewItems = items
        self.adapter.performUpdates(animated: true, completion: nil)
    }
}

// MARK: - ReviewsProviderDelegate
extension ReviewItemsViewController: LabelSectionControllerDelegate {
    
    func didSelectItem(reviewItem: ReviewItem) {
        self.provider?.scheduleNextReviewForItem(reviewItem: reviewItem)
    }
}
