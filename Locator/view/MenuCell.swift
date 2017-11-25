//
//  MenuCell.swift
//  Locator
//
//  Created by Innocent Magagula on 11/19/17.
//  Copyright © 2017 Tucksee. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            menuNameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            menuImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var menu: Menu? {
        didSet{
            menuNameLabel.text = menu?.name
            
            if let imageName = menu?.imageName{
                menuImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                menuImageView.tintColor = UIColor.darkGray
            }
            
        }
    }
    
    let menuNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
       return label
    }()
    
    let menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()

        addSubview(menuNameLabel)
        addSubview(menuImageView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(25)]-8-[v1]|", views: menuImageView, menuNameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: menuNameLabel)
        addConstraintsWithFormat(format: "V:[v0(25)]", views: menuImageView)
        
        addConstraint(NSLayoutConstraint(item: menuImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
