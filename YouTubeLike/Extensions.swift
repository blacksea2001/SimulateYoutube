//
//  Extensions.swift
//  YouTubeLike
//
//  Created by Wesley on 2017/5/16.
//  Copyright © 2017年 WesleyChen. All rights reserved.
//

import UIKit

let logger: Logger = PrintLogger(minimumLogLevel: .verbose)

extension UIView {
    func addConstraintsWithFormat(format: String, view: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in view.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}



let imageCache = NSCache<NSString, UIImage>()


// There are two issues need to be fixed.
// First one is no need to load every single UIImage every time. So we use cache to fix this problem.
// Second one is if we scorll down but images doesn't be loaded completely, it will display wrong picture.
// We fix this issue by using custom image view class inherit UIImage.

//extension UIImageView {
class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        // Check if there is cache
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                logger.log(logLevel: .debug, "\(error)")
                return
            }
            
            logger.log(logLevel: .debug, "\(data!)")
            
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data: data!)
                
                // To fix issue two
                // Check if image url string is equal to the url string we pass in
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            }
        }.resume()
    }
    
    
}
