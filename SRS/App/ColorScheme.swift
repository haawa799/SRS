//
//  ColorScheme.swift
//  SRS
//
//  Created by Andrii Kharchyshyn on 2/22/18.
//  Copyright © 2018 Andrii Kharchyshyn. All rights reserved.
//

import Foundation
import Chameleon

class ColorSchemaManager {
    
    class func applySchema(schema: ColorSchema) {
        Chameleon.setGlobalThemeUsingPrimaryColor(schema.mainColor, with: UIContentStyle.light)
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : schema.contrastingColor]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : schema.contrastingColor]
    }
    
}

protocol ColorSchema {
    var mainColor: UIColor { get }
    var contrastingColor: UIColor { get }
    var backgroundColor: UIColor { get }
}

struct AppColorSchema: ColorSchema {
    
    let mainColor = UIColor(named: "ColorMain")!
    let contrastingColor = UIColor(named: "ColorContrasting")!
    let backgroundColor = UIColor(named: "ColorBackground")!
    
}
