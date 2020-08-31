//
//  Services.swift
//  DrinkersApp
//
//  Created by Preeteesh Remalli on 16/06/18.
//  Copyright © 2018 Preeteesh Remalli. All rights reserved.
//

import Foundation
import SwiftyJSON
class services {
    static let instance = services()
    var barDetailArray : [BarDetails] = []
    func getBarDetails(lat:String, lon:String,completion: @escaping (_ Success: Bool,_ barDetailArra : [BarDetails]) -> ()){
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(lon)&radius=2000&types=bar&key=AIzaSyCUyziYISlAi5fhzDQQ0YLW0Oyj1cXfDIM")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("request failed \(error.debugDescription)")
                return
            }
            do {
                let results = try JSON(data: data)
                let json = results["results"].arrayValue
                
                for  var eachResult in json{
                    let name = eachResult["name"].stringValue
                    let photoReference = "url"
                    let rating = eachResult["rating"].stringValue
                    let lat = eachResult["geometry"]["location"]["lat"].stringValue
                    let lon = eachResult["geometry"]["location"]["lng"].stringValue
                    let address = eachResult["vicinity"].stringValue
                    //BarDetails.instance.barDetails(name: name, photoReference: photoReference, rating: rating, lat:lat, lon: lon)
                    let bar = BarDetails(name: name, photoReference: photoReference, rating: rating, lat: lat, lon: lon, address: address)
                    self.barDetailArray.append(bar)
                }
                completion(true,self.barDetailArray)
                //print(json)
                
            } catch let parseError {
                print("parsing error: \(parseError)")
                completion(false,[])
            }
        }
        task.resume()
    }
    
    func getDetails(){
        
        let url = URL(string: "https://my.api.mockaroo.com/api.json?key=7f8b1610")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("request failed \(error.debugDescription)")
                return
            }
            do {
                let results = try JSON(data: data)
                let json = results.arrayValue

                //print(json)
                
            } catch let parseError {
                print("parsing error: \(parseError)")
            }
        }
        task.resume()
    }
    
    
}
