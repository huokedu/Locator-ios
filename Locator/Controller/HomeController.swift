//
//  ViewController.swift
//  Locator
//
//  Created by Innocent Magagula on 11/11/17.
//  Copyright © 2017 Tucksee. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    var artists: [Artist]?
    
    func fetchArtist(){
        let url = URL(string: "http://www.omdbapi.com/?s=Batman&apikey=477f590b")
        URLSession.shared.dataTask(with: url!){data, response, error in
            
            if error != nil{
                print(error!)
                return
            }
            
            //check for valid json response
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                if let totalResults = json as? [String: AnyObject]{
                    
                    self.artists = [Artist]()
                    for dictionary in totalResults["Search"] as! [[String: AnyObject]]{
                        
                        let artist = Artist()
                        artist.eventTitle = dictionary["Title"] as? String
                        artist.eventPlace = "FNB Stadium"
                        artist.location = "Soccer City Ave, Nasrec, Johannesburg"
                        artist.artistName = "Batman"
                        artist.dateTime = "Tonight: 8pm till late "
                        artist.thumbnailImage = dictionary["Poster"] as? String
                        artist.userProfileImage = dictionary["Poster"] as? String
                        self.artists?.append(artist)
                        
                    }
                }
                DispatchQueue.main.async {
                     self.collectionView?.reloadData()
                }
               
            }
            catch let jsonError {
                //hande malformed error response
                print(jsonError)
            }
            
            
            }.resume()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get artist
        fetchArtist()
        
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
        
        let moreBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_more_vert_white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleShowMenuTap))
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem,searchBarButtonItem]
    }

    
    lazy var menuLauncher: MenuControlller = {
        let menuController = MenuControlller()
        menuController.homeController = self
        return menuController
    }()
    
    @objc func handleShowMenuTap() {
        menuLauncher.showMenu()
        
    }

    @objc func handleSearchButtonTap() {
        print("SEARCH")
    }
    

    func showSettingViewController(menu: Menu) {
        let controller = UIViewController()
        controller.navigationItem.title = menu.name
        controller.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.pushViewController(controller, animated: true)
    }
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //return number of rows in table
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        //return count otherwise 0
        return artists?.count ?? 0
        
    }
    
    //return each cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ArtistCell
        
        cell.artist = artists?[indexPath.item]
        
        return cell
    }
    
    //set height for each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
}











