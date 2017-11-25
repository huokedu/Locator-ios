//
//  EventsCell.swift
//  Locator
//
//  Created by Innocent Magagula on 11/26/17.
//  Copyright © 2017 Tucksee. All rights reserved.
//

import UIKit

class EventsCell: SeedCell {
    
    override func fetchArtist() {
        //awesone completion block huhu
        Datamanager.instance.fetchEvents(completion: ({ (artists: [Artist]) in
            self.artists = artists
            self.collectionView.reloadData()
        }))
    }
    
}
