//
//  ViewController.swift
//  Locator
//
//  Created by Innocent Magagula on 11/11/17.
//  Copyright © 2017 Tucksee. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    var artists: [Artist] = {
        var blackCoffee = Artist()
        blackCoffee.eventTitle = "Ibiza"
        blackCoffee.eventPlace = "FNB Stadium"
        blackCoffee.location = "Soccer City Ave, Nasrec, Johannesburg"
        blackCoffee.artistName = "Back Coffee"
        blackCoffee.dateTime = "Tonight: 8pm till late "
        blackCoffee.thumbnailImage = "black_coffee"
        blackCoffee.userProfileImage = "back_coffee_face"
        
        var tira = Artist()
        tira.artistName = "DJ Tira"
        tira.eventPlace = "Eyadini Lounge"
        tira.eventTitle = "Celebrating December"
        tira.location = "3 Peace Rd, Umlazi, Durban"
        tira.dateTime = "Tonight: 6pm to 6am "
        tira.thumbnailImage = "tira"
        tira.userProfileImage = "tira_face"
        
        var babes = Artist()
        babes.artistName = "Babes Wodumo"
        babes.eventTitle = "Gandaganda launch"
        babes.eventPlace = "Moses Mabhida Stadium"
        babes.location = "44 Isaiah Ntshangase Rd, Stamford Hill, Durban"
        babes.dateTime = "Tonight:6pm till late"
        babes.thumbnailImage = "babes_wodumo"
        babes.userProfileImage = "babes_wodumo_face"
        
        var zodwa = Artist()
        zodwa.artistName = "Zodwa Wabantu"
        zodwa.eventPlace = "Eyadini Lounge"
        zodwa.eventTitle = "Celebrating Youth Day"
        zodwa.location = "Eyadini Lounge"
        zodwa.dateTime = "Tommorrow: 9pm till late"
        zodwa.thumbnailImage = "zodwa_wabantu"
        zodwa.userProfileImage = "zodwa_wabantu_face"
        
        
       return [blackCoffee,zodwa,tira,babes]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation item title
        navigationItem.title = "Celebrities"
        navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Celebrities"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        //set background color
        collectionView?.backgroundColor = UIColor.white
        
        //register cell class
        collectionView?.register(ArtistCell.self, forCellWithReuseIdentifier: "cellId")
        
        //push the content and scroll to accomodate our custom menu bar
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
        setupMenuButtons()
    
    }
    
    let menuBar: MenuBar = {
        let bar = MenuBar()
        return bar
    }()
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    func setupMenuButtons(){
        let searchImage = UIImage(named: "ic_search_white")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearchButtonTap))
        
        let moreBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_more_vert_white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMoreButtonTap))
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem,searchBarButtonItem]
    }

    @objc func handleSearchButtonTap() {
        print("SEARCH")
    }
    
    @objc func handleMoreButtonTap() {
        print("MORE")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //return number of rows in table
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artists.count
    }
    
    //return each cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ArtistCell
        
        cell.artist = artists[indexPath.item]
        
        return cell
    }
    
    //set height for each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
}











