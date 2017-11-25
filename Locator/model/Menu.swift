//
//  Menu.swift
//  Locator
//
//  Created by Innocent Magagula on 11/19/17.
//  Copyright © 2017 Tucksee. All rights reserved.
//

import UIKit
class Menu: NSObject {
    let name: MenuName
    let imageName: String
    
    init(name: MenuName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
//type safe menus
enum MenuName: String {
    case Settings = "Settings"
    case Help = "Help"
    case Feedback = "Feedback"
}
