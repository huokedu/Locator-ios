//
//  SeedCell.swift
//  Locator
//
//  Created by Innocent Magagula on 11/25/17.
//  Copyright © 2017 Tucksee. All rights reserved.
//

import UIKit




class SeedCell: BaseCell, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    lazy var collectionView : UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.white
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    var artists: [Artist]?
    
    let cellId = "cellId"
    
    func fetchArtist(){
        //awesone completion block huhu
        Datamanager.instance.fetchArtists(completion: ({ (artists: [Artist]) in
            self.artists = artists
            self.collectionView.reloadData()
        }))
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .green
        
        fetchArtist()
        
        addSubview(collectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(ArtistCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
        //return number of rows in table
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            //return count otherwise 0
            return artists?.count ?? 0
    
        }
    
        //return each cell
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ArtistCell
            cell.artist = artists?[indexPath.item]
            return cell
        }
    
        //set height for each cell
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let height = (frame.width - 16 - 16) * 9 / 16
    
            return CGSize(width: frame.width, height: height + 16 + 88)
        }
}















