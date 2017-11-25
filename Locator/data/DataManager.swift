//
//  DataManager.swift
//  Locator
//
//  Created by Innocent Magagula on 11/18/17.
//  Copyright © 2017 Tucksee. All rights reserved.
//

import UIKit

class Datamanager: NSObject{
    
    static let instance = Datamanager()
    
    func fetchArtists(completion: @escaping ([Artist]) -> ()){
        
        let url = URL(string: "http://www.omdbapi.com/?s=Batman&apikey=477f590b")
        URLSession.shared.dataTask(with: url!){data, response, error in
            
            if error != nil{
                print(error!)
                return
            }
            
            //check for valid json response
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
               
                var artists = [Artist]()
                if let totalResults = json as? [String: AnyObject]{

                    for dictionary in totalResults["Search"] as! [[String: AnyObject]]{
                        
                        let artist = Artist()
                        artist.eventTitle = dictionary["Title"] as? String
                        artist.eventPlace = "FNB Stadium"
                        artist.location = "Soccer City Ave, Nasrec, Johannesburg"
                        artist.artistName = "Batman"
                        artist.dateTime = "Tonight: 8pm till late "
                        artist.thumbnailImage = dictionary["Poster"] as? String
                        artist.userProfileImage = dictionary["Poster"] as? String
                        artists.append(artist)
                        
                    }
                }
                DispatchQueue.main.async {
                    completion(artists)
                }
            }
            catch let jsonError {
                //hande malformed error response
                print(jsonError)
            }
        }.resume()
    }
    func fetchClubs(completion: @escaping ([Artist]) -> ()){
        
        let url = URL(string: "http://www.omdbapi.com/?s=007&apikey=477f590b")
        URLSession.shared.dataTask(with: url!){data, response, error in
            
            if error != nil{
                print(error!)
                return
            }
            
            //check for valid json response
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var artists = [Artist]()
                if let totalResults = json as? [String: AnyObject]{
                    
                    for dictionary in totalResults["Search"] as! [[String: AnyObject]]{
                        
                        let artist = Artist()
                        artist.eventTitle = dictionary["Title"] as? String
                        artist.eventPlace = "FNB Stadium"
                        artist.location = "Soccer City Ave, Nasrec, Johannesburg"
                        artist.artistName = "Batman"
                        artist.dateTime = "Tonight: 8pm till late "
                        artist.thumbnailImage = dictionary["Poster"] as? String
                        artist.userProfileImage = dictionary["Poster"] as? String
                        artists.append(artist)
                        
                    }
                }
                DispatchQueue.main.async {
                    completion(artists)
                }
            }
            catch let jsonError {
                //hande malformed error response
                print(jsonError)
            }
            }.resume()
    }
    
    func fetchEvents(completion: @escaping ([Artist]) -> ()){
        
        let url = URL(string: "http://www.omdbapi.com/?s=017&apikey=477f590b")
        URLSession.shared.dataTask(with: url!){data, response, error in
            
            if error != nil{
                print(error!)
                return
            }
            
            //check for valid json response
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var artists = [Artist]()
                if let totalResults = json as? [String: AnyObject]{
                    
                    for dictionary in totalResults["Search"] as! [[String: AnyObject]]{
                        
                        let artist = Artist()
                        artist.eventTitle = dictionary["Title"] as? String
                        artist.eventPlace = "FNB Stadium"
                        artist.location = "Soccer City Ave, Nasrec, Johannesburg"
                        artist.artistName = "Batman"
                        artist.dateTime = "Tonight: 8pm till late "
                        artist.thumbnailImage = dictionary["Poster"] as? String
                        artist.userProfileImage = dictionary["Poster"] as? String
                        artists.append(artist)
                        
                    }
                }
                DispatchQueue.main.async {
                    completion(artists)
                }
            }
            catch let jsonError {
                //hande malformed error response
                print(jsonError)
            }
            }.resume()
    }
}
