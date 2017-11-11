//
//  ArtistCell.swift
//  Locator
//
//  Created by Innocent Magagula on 11/11/17.
//  Copyright © 2017 Tucksee. All rights reserved.
//

import UIKit

//everytime dequeueReusableCell is called it will run the inti method thus running our setupviews
class ArtistCell: BaseCell{
    
    var artist: Artist? {
        didSet {
            
            if let artistName = artist?.artistName,let eventName = artist?.eventTitle{
                let title = "\(artistName) • \(eventName)"
                titleLabel.text = title
            }

            if let userPic = artist?.thumbnailImage{
                thumbnailImageView.image = UIImage(named: (userPic))
            }
            
            if let profilePic = UIImage(named:(artist?.userProfileImage)!) {
                userProfileImageView.image = profilePic
            }
            else{
                userProfileImageView.image = UIImage(named: "innocent")
            }
            
            if let eventTime = artist?.dateTime,let place = artist?.eventPlace, let address = artist?.location{
                let location = "\(eventTime) • \(place) • \(address)"
                subTitleTextView.text = location
            }
           //measure the title heigh and increase the constant
            if let title  = artist?.artistName,let event = artist?.eventTitle{
                let titleString = "\(title) \(event)"
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimateTitleRect = NSString(string: titleString).boundingRect(with: size, options: option, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimateTitleRect.size.height > 17 {
                    titleLabelContraint?.constant = 45
                }
                else{
                     titleLabelContraint?.constant = 20
                }
            }
            
        }
    }
    
    //create the image view
    let thumbnailImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        return imageview
    }()
    
    //create the user profile view
    let userProfileImageView: UIImageView = {
        let imageview = UIImageView()
        //making is circular require half of the with an heigh of the image
        imageview.layer.cornerRadius = 22
        imageview.layer.masksToBounds = true
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    //create the title view
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    //create the subtitle view
    let subTitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    var titleLabelContraint: NSLayoutConstraint?
    
    override func setupViews(){
        //add to view
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleTextView)
        
        //horizontal axis for thumbnail
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        //user profile horizontal constraints
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        //vertical axis for thumnail user pic and separator
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView,userProfileImageView,separatorView)

        
        //horizontal axis for separator
        addConstraintsWithFormat(format: "H:|-16-[v0]|", views: separatorView)
        
        
        
        
        //description is dynamic the content might change so we need to have dynamic contrains
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint * important to be added like this for later modification
        titleLabelContraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 50)
        addConstraint(titleLabelContraint!)
        
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint * important to be added like this for later modification
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        
    }

}


