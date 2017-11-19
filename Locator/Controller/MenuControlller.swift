//
//  MenuViewControlller.swift
//  Locator
//
//  Created by Innocent Magagula on 11/19/17.
//  Copyright © 2017 Tucksee. All rights reserved.
//

import UIKit

class MenuControlller : NSObject {
    
    let overlayView = UIView()
    
    @objc func showMenu() {
        
        //make an overlay that fill entire screen
        if let window = UIApplication.shared.keyWindow{
            
            overlayView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            //add handler to dismiss overlay when clicked
            overlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenu)))
            
            window.addSubview(overlayView)
            overlayView.frame = window.frame
            overlayView.alpha = 0
            
            //animate showing the black view
            UIView.animate(withDuration: 0.5, animations: {
                self.overlayView.alpha = 1
            })
        }
    }

    @objc func dismissMenu() {
        
        //animate showing the black view
        UIView.animate(withDuration: 0.5, animations: {
            self.overlayView.alpha = 0
        })
    }
    override init(){
        super.init()
    }
}
