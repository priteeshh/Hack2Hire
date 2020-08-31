//
//  RegisterVC.swift
//  Hack2HireProject
//
//  Created by Preeteesh Remalli on 20/07/19.
//  Copyright © 2019 Preeteesh Remalli. All rights reserved.
//

import UIKit
import CoreLocation

class RegisterAsCustomer: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var userNameTF: AppTextField!
    @IBOutlet weak var passwordTF: AppTextField!
    @IBOutlet weak var phoneNumberTF: AppTextField!
    @IBOutlet weak var emailTF: AppTextField!
    @IBOutlet weak var loactionTF: AppTextField!
    @IBOutlet weak var zipCode: AppTextField!
    @IBOutlet weak var orbitImageView: UIImageView!
    @IBOutlet weak var innerOrbitImageView: UIImageView!
    var locationManager: CLLocationManager!
    var locManager = CLLocationManager()
    var lat = 0.0
    var long = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //titleLbl.text = self.user?.username
        // Animate orbits to slowly rotate
        orbitImageView.startRotating(duration: 25, clockwise: false, delay: 1)
        innerOrbitImageView.startRotating(duration: 20, clockwise: true, delay: 1)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last! as CLLocation
        /* you can use these values*/
         lat = location.coordinate.latitude
         long = location.coordinate.longitude
        print(lat)
        print(long)
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        // prepare json data
        guard let email = emailTF.text, !email.isEmpty else {
            errorAlertShow()
            return
        }

        guard let username = userNameTF.text, !username.isEmpty else {
            errorAlertShow()
            return
        }
        guard let phoneNumber = phoneNumberTF.text, !phoneNumber.isEmpty else {
            errorAlertShow()
            return
        }
        guard let zipCode = zipCode.text, !zipCode.isEmpty else {
            errorAlertShow()
            return
        }
        guard let location = loactionTF.text, !location.isEmpty else {
            errorAlertShow()
            return
        }
        guard let password = passwordTF.text, !password.isEmpty else {
            errorAlertShow()
            return
        }
        let json: [String: Any] = ["email": email,
                                   "customername": username,
                                   "address": "Sample Address",
                                   "phno": phoneNumber,
                                   "zipcode": zipCode,
                                   "longitude": lat,
                                   "latitude":long,
                                   "location":location,
                                   "pasword":password
                                   ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: "https://mypharmacy-table9.apps.hack2hire.net/customer/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        
        task.resume()
        
    }
    func errorAlertShow(){
        let alert = UIAlertController(title: "Alert", message: "Make sure all fields are not empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
}
