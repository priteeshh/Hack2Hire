//
//  LoginVC.swift
//  Hack2HireProject
//
//  Created by Preeteesh Remalli on 20/07/19.
//  Copyright © 2019 Preeteesh Remalli. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var orbitImageView: UIImageView!
    @IBOutlet weak var innerOrbitImageView: UIImageView!
    @IBOutlet weak var userNameTF: AppTextField!
    @IBOutlet weak var passwordTF: AppTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "http://3.87.53.238")
        services.instance.getDetails()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //titleLbl.text = self.user?.username
        // Animate orbits to slowly rotate
        orbitImageView.startRotating(duration: 25, clockwise: false, delay: 1)
        innerOrbitImageView.startRotating(duration: 20, clockwise: true, delay: 1)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = userNameTF.text, !email.isEmpty else {
            errorAlertShow()
            return
        }
        
        guard let password = passwordTF.text, !password.isEmpty else {
            errorAlertShow()
            return
        }

        let json: [String: Any] = ["customername": email,
                                   "pasword":password
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: "https://mypharmacy-table9.apps.hack2hire.net/customer/validate")!
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
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "signIn", sender: responseJSON["customerid"]!)
                }
                print(responseJSON)
            }else{
                DispatchQueue.main.async {
                    self.errorInvalidAlertShow()
                }
                
                print("invalid credentials")
            }
            
            
        }
        
        task.resume()
        
        
    }
    @IBAction func signInButtonTapped(_ sender: Any){
        let alertController = UIAlertController(title: "Choose type of account", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction( title : "as a retailer" ,
                                         style : .default) { action in
                                            print("action triggered")
        self.performSegue(withIdentifier: "retailer", sender: self)

        }
        let alertAction2 = UIAlertAction( title : "as a customer" ,
                                         style : .default) { action in
                                            print("action triggered")
        self.performSegue(withIdentifier: "customer", sender: self)
        }
        let alertAction3 = UIAlertAction( title : "cancel" ,
                                          style : .default) { action in
                                            print("action triggered")
        }
        alertController.addAction(alertAction)
        alertController.addAction(alertAction2)
        alertController.addAction(alertAction3)
        self.present(alertController, animated: false, completion: nil)
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
    func errorInvalidAlertShow(){
        let alert = UIAlertController(title: "Alert", message: "Invalid credentials", preferredStyle: .alert)
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // GetUIAlertController.Styleer using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "retailer") {
            // pass data to next view
        }
        if (segue.identifier == "customer") {
            // pass data to next view
        }
        if (segue.identifier == "signIn") {
            // pass data to next view
            UserDefaults.standard.set(sender , forKey: "customerid") //setObject

        }
        
        
    }
 

}
