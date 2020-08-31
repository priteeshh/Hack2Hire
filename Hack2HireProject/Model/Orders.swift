//
//  Orders.swift
//  Hack2HireProject
//
//  Created by Preeteesh Remalli on 21/07/19.
//  Copyright © 2019 Preeteesh Remalli. All rights reserved.
//

import Foundation
class Orders{
    //static let instance = BarDetails()
    
    public private(set) var customerId = ""
    public private(set) var orderStatus = ""
    public private(set) var documentId = ""
    public private(set) var orderDate = ""
    public private(set) var orderId = ""
    public private(set) var totalAmount = ""
    
    init(customerId: String, orderStatus : String, documentId : String, orderDate : String, orderId : String, totalAmount: String) {
        self.customerId = customerId
        self.orderStatus = orderStatus
        self.documentId = documentId
        self.orderDate = orderDate
        self.orderId = orderId
        self.totalAmount = totalAmount
        
    }
    //    func barDetails(name: String, photoReference : String, rating : String, lat : String, lon : String){
    //        self.name = name
    //        self.photoReference = photoReference
    //        self.rating = rating
    //        self.lat = lat
    //        self.lon = lon
    //}
}
