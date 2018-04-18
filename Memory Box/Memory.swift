//
//  Memory.swift
//  Memory Box
//
//  Created by Audrey Basinger on 1/22/18.
//  Copyright © 2018 Audrey Basinger. All rights reserved.
//

import UIKit

class Memory: NSObject {
    
    var name: String
    var date: String
    var image: UIImage
    var details: String

    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        date = aDecoder.decodeObject(forKey: "date") as! String
        image = aDecoder.decodeObject(forKey: "image") as! UIImage
        details = aDecoder.decodeObject(forKey: "details") as! String
    }

    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(details, forKey: "details")
    }
    
  //  func encode(_ object: Any?, forKey key: String) {
  //      encode(name, forKey: "name")
  //      encode(date, forKey: "date")
//        encode(image, forKey: "image")
//    }
    
    init(name: String, date: String, image: UIImage, details: String) {
        self.name = name
        self.date = date
        self.image = image
        self.details = details
    }

}
