//
//  ViewController.swift
//  Locator
//
//  Created by Innocent Magagula on 11/11/17.
//  Copyright © 2017 Tucksee. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

   
    let cellId = "cellId"
    let clubCellId = "clubCellId"
    let eventsCellId = "eventCellId"
    let titles = ["Celebrities","Clubs","Events"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Celebrities"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        

        setupCollectionView()
        setupMenuBar()
        setupMenuButtons()
    
    }
    
    func setupCollectionView(){
        //set background color
        collectionView?.backgroundColor = UIColor.white
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        //register artist cell class
        //collectionView?.register(ArtistCell.self, forCellWithReuseIdentifier: "cellId")
        
        //collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.register(SeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(ClubCell.self, forCellWithReuseIdentifier: clubCellId)
        collectionView?.register(EventsCell.self, forCellWithReuseIdentifier: eventsCellId)
        
        //push the content and scroll to accomodate our custom menu bar
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView?.isPagingEnabled = true
    }
    
    lazy var menuBar: MenuBar = {
        let bar = MenuBar()
        bar.homeController = self
        return bar
    }()
    
    private func setupMenuBar(){
//        navigationController?.hidesBarsOnSwipe = true
//        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
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
       print("search")
    }
    
    func scrollToItemAtIndex(index: Int){
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
        setTitleForIndex(index: index)
    }

    func showSettingViewController(menu: Menu) {
        let controller = UIViewController()
        controller.navigationItem.title = menu.name.rawValue
        controller.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.pushViewController(controller, animated: true)
    }
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftConstrain?.constant = scrollView.contentOffset.x / 3
    }

    
    private func setTitleForIndex(index: Int){
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = titles[index]
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        
        setTitleForIndex(index: Int(index))

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier: String
        
        if indexPath.item == 1 {
            cellIdentifier = clubCellId
        }
        else if indexPath.item == 2 {
            cellIdentifier = eventsCellId
        }
        else{
            cellIdentifier = cellId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    

}











