//
//  Extensions.swift
//  Locator
//
//  Created by Innocent Magagula on 11/11/17.
//  Copyright © 2017 Tucksee. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat)->UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView{

    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionery = [String:UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionery[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionery))        
    }
    
    func centerX(view: UIView) {
        addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
    func centerY(view: UIView) {
        addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}

//image cache
let imageCache = NSCache<AnyObject, AnyObject>()

class BufferImageView: UIImageView {
    
    var imageUrlSring: String?
    
    func loadImagefromUrl(urlString: String){
        
        imageUrlSring = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        
        URLSession.shared.dataTask(with: url!){data, response, error in
            if error != nil{
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlSring == urlString {
                     self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
            
            }.resume()
    }
}
