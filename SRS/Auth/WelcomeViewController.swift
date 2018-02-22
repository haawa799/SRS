//
//  WelcomeViewController.swift
//  SRS
//
//  Created by Andrii Kharchyshyn on 2/2/18.
//  Copyright © 2018 Andrii Kharchyshyn. All rights reserved.
//

import UIKit
import RealmSwift
import SanjiPersistance

class WelcomeViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Welcome"
        
        if let _ = SyncUser.current {
            // We have already logged in here!
//            SyncUser.current?.logOut()
            let kanjiSyncConfig = SyncConfiguration(user: SyncUser.current!, realmURL: Constants.KANJI_REALM_URL)
            
            let allKanjiTypesArray = [
                Animation.self,
                Kanji.self,
                Kunyomi.self,
                MainRadical.self,
                Meaning.self,
                MeaningWord.self,
                Onyomi.self,
                Position.self,
                Radical.self,
                StringToken.self,
                StrokeFrame.self,
                StrokesSet.self,
                Video.self
            ]

            
            let kanjiRealm = try! Realm(configuration: Realm.Configuration(syncConfiguration: kanjiSyncConfig, objectTypes: allKanjiTypesArray))
            
            let reviewSyncConfig = SyncConfiguration(user: SyncUser.current!, realmURL: Constants.REALM_URL)
            let reviewRealm = try! Realm(configuration: Realm.Configuration(syncConfiguration: reviewSyncConfig, objectTypes: [ReviewItem.self]))
            
            let provider = RealmReviewsProvider()
            let itemsViewController = ReviewItemsViewController(dataprovider: provider)
            self.navigationController?.pushViewController(itemsViewController, animated: true)
        } else {
            let alertController = UIAlertController(title: "Login to Realm Cloud", message: "Supply a nice nickname!", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Login", style: .default, handler: { [unowned self]
                alert -> Void in
                let textField = alertController.textFields![0] as UITextField
                let creds = SyncCredentials.nickname(textField.text!, isAdmin: true)
                
                SyncUser.logIn(with: creds, server: Constants.AUTH_URL, onCompletion: { [weak self](user, err) in
                    if let _ = user {
                        self?.navigationController?.pushViewController(ReviewItemsViewController(), animated: true)
                    } else if let error = err {
                        fatalError(error.localizedDescription)
                    }
                })
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                textField.placeholder = "A Name for your user"
            })
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
