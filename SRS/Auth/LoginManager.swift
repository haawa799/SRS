//
//  LoginManager.swift
//  SRS
//
//  Created by Andrii Kharchyshyn on 2/21/18.
//  Copyright © 2018 Andrii Kharchyshyn. All rights reserved.
//

import Foundation
import RealmSwift

class LoginManager {
    
    var isUserLoggedIn: Bool {
        return SyncUser.current != nil
    }
    
}
