//
//  BarDetails.swift
//  DrinkersApp
//
//  Created by Preeteesh Remalli on 16/06/18.
//  Copyright © 2018 Preeteesh Remalli. All rights reserved.
//

import Foundation
class BarDetails{
    //static let instance = BarDetails()
    
    public private(set) var name = ""
    public private(set) var photoReference = ""
    public private(set) var rating = ""
    public private(set) var lat = ""
    public private(set) var lon = ""
    public private(set) var address = ""

    init(name: String, photoReference : String, rating : String, lat : String, lon : String, address: String) {
        self.name = name
        self.photoReference = photoReference
        self.rating = rating
        self.lat = lat
        self.lon = lon
        self.address = address
    }
//    func barDetails(name: String, photoReference : String, rating : String, lat : String, lon : String){
//        self.name = name
//        self.photoReference = photoReference
//        self.rating = rating
//        self.lat = lat
//        self.lon = lon
//}
}
