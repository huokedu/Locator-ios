//
//  MenuViewControlller.swift
//  Locator
//
//  Created by Innocent Magagula on 11/19/17.
//  Copyright © 2017 Tucksee. All rights reserved.
// collection view y is set to 20 the size of the status bar
//

import UIKit

class MenuControlller : NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let overlayView = UIView()
    
    let drawerControllerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let headerBackgroundImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "header_wallpaper")
        return imageView
    }()
    
    let closeDrawerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "ic_keyboard_backspace_white")?.withRenderingMode(.alwaysOriginal)
        imageView.tintColor = UIColor.white
        
        
        //add handler to dismiss overlay when clicked
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenu)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let profileDecoratorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    //create the title view
    let usernameUILabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.darkGray
        label.text = "Innocent Magagula"
        label.textAlignment = .right
        return label
    }()
    
    let profileHeaderView: UIView = {
        let view = UIView()
        return view
    }()
    

    
    //create the user profile view
    let profilePictureImageView: UIImageView = {
        let imageview = UIImageView()
        //making is circular require half of the with an heigh of the image
        imageview.layer.cornerRadius = 65
        imageview.layer.masksToBounds = true
        imageview.contentMode = .scaleAspectFill
        imageview.image = UIImage(named: "innocent")
        imageview.layer.borderWidth = 2
        imageview.layer.borderColor = UIColor.darkGray.cgColor
        return imageview
    }()
    
    let collectionView: UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let menus: [Menu] = {
        return [Menu(name: "Settings", imageName: "ic_settings"),
                Menu(name: "Help", imageName: "ic_help"),
                Menu(name: "Feedback", imageName: "ic_feedback")]
    }()
    
    var homeController: HomeController?
    
    @objc func showMenu() {
        
        //make an overlay that fill entire screen
        if let window = UIApplication.shared.keyWindow{
            
            overlayView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            //add handler to dismiss overlay when clicked
            overlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenu)))
            window.addSubview(overlayView)

            drawerControllerView.addSubview(collectionView)
            
            drawerControllerView.addSubview(profileHeaderView)
            
  
            
            //background header image view profile section
            profileHeaderView.addSubview(headerBackgroundImageView)
            
            profileHeaderView.addConstraintsWithFormat(format: "H:|[v0]|", views: headerBackgroundImageView)
            profileHeaderView.addConstraintsWithFormat(format: "V:|[v0]|", views: headerBackgroundImageView)
            
            //user profile image
            profileHeaderView.addSubview(profilePictureImageView)

            profileHeaderView.addConstraintsWithFormat(format: "H:[v0(130)]-20-|", views: profilePictureImageView)
            profileHeaderView.addConstraintsWithFormat(format: "V:[v0(130)]", views: profilePictureImageView)
            
            profileHeaderView.centerY(view: profilePictureImageView)

            
            //close drawer controller image view
            profileHeaderView.addSubview(closeDrawerImageView)
            
            profileHeaderView.addConstraintsWithFormat(format: "H:|-15-[v0(35)]", views: closeDrawerImageView)
            profileHeaderView.addConstraintsWithFormat(format: "V:|-10-[v0(35)]", views: closeDrawerImageView)
            
            //user name profile name
            profileHeaderView.addSubview(usernameUILabel)
            //line to below profile to mark end of profile view
            profileHeaderView.addSubview(profileDecoratorLineView)
            
            profileHeaderView.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: usernameUILabel)
            profileHeaderView.addConstraintsWithFormat(format: "H:|[v0]-10-|", views: profileDecoratorLineView)

            profileHeaderView.addConstraintsWithFormat(format: "V:[v0(50)]-5-[v1(1)]|", views: usernameUILabel,profileDecoratorLineView)

            
            window.addSubview(drawerControllerView)

            drawerControllerView.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
            drawerControllerView.addConstraintsWithFormat(format: "V:|[v0(250)][v1]|", views:profileHeaderView,collectionView)
            drawerControllerView.addConstraintsWithFormat(format: "H:|[v0]|", views: profileHeaderView)
            


            
            //@TODO fix this warnings
            let menuWidth: CGFloat =  window.frame.width * 0.8
            let x = 0 - menuWidth
            
            //collectionView.frame = CGRect(x: x, y: 20,width: menuWidth , height: window.frame.height)
            drawerControllerView.frame = CGRect(x: x, y: 20,width: menuWidth , height: window.frame.height)
            
            overlayView.frame = window.frame
            overlayView.alpha = 0
            
            drawerControllerView.layoutIfNeeded()
            
            //animate showing views
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

                self.overlayView.alpha = 1
                self.drawerControllerView.frame = CGRect(x: 0, y: 20, width: menuWidth, height: window.frame.height)
            }, completion: nil)

        }
    }

    @objc func dismissMenu() {
        
        //animate showing the black view
        UIView.animate(withDuration: 0.5, animations: {
            self.overlayView.alpha = 0

            //hide menu 
            if let window = UIApplication.shared.keyWindow {
                self.drawerControllerView.frame = CGRect(x: 0 - window.frame.width * 0.8, y: 20,width: window.frame.width * 0.8 , height: window.frame.height)
            }
        })
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    let cellId = "cellId"
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        let menu = menus[indexPath.item]
        cell.menu = menu
        
        return cell
    }
    
    //set height for each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     return CGSize(width: self.collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.overlayView.alpha = 0
            //hide menu
            if let window = UIApplication.shared.keyWindow {
                self.drawerControllerView.frame = CGRect(x: 0 - window.frame.width * 0.8, y: 20,width: window.frame.width * 0.8 , height: window.frame.height)
            }
        }) { (completed: Bool) in
            
            let menu = self.menus[indexPath.item]
            
            self.homeController?.showSettingViewController(menu: menu)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override init(){
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
    }
}
