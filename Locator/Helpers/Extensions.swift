//
//  Extensions.swift
//  Locator
//
//  Created by Innocent Magagula on 11/11/17.
//  Copyright © 2017 Tucksee. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat)->UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}


//this helps for easy adding of contraints
//avoid code repetation eg

//    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(),
//    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(2)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : separatorView]))
extension UIView{

    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionery = [String:UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionery[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionery))        
    }
}
