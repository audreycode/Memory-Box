//
//  Memory.swift
//  Memory Box
//
//  Created by Audrey Basinger on 1/22/18.
//  Copyright © 2018 Audrey Basinger. All rights reserved.
//

import UIKit

class Memory: NSObject, NSCoding {
    
    var name: String
    var date: String
    var image: UIImage
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        date = aDecoder.decodeObject(forKey: "date") as! String
        print(type(of: aDecoder.decodeObject(forKey: "image")))
        image = aDecoder.decodeObject(forKey: "image") as! UIImage
        print(type(of: aDecoder.decodeObject(forKey: "image")))
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(image, forKey: "image")
    }
    
    init(name: String, date: String, image: UIImage) {
        self.name = name
        self.date = date
        self.image = image
    }

}
