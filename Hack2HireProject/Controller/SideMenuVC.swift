//
//  SideMenuVC.swift
//  Hack2HireProject
//
//  Created by Preeteesh Remalli on 20/07/19.
//  Copyright © 2019 Preeteesh Remalli. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var sideMenuTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.width - 250
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iteamsArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = sideMenuTableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? SideMenuCell{
            cell.configureCell(index: indexPath.item)
            return cell
        }
        return SideMenuCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.revealViewController().revealToggle(animated: true)

        if indexPath.row == 0 {
            //delegate?.selectedMenuItem(item: indexPath.row)
        }
        else if indexPath.row == 1{
            
            self.performSegue(withIdentifier: "placeOrder", sender: self)
            //delegate?.selectedMenuItem(item: indexPath.row)
            //self.revealViewController().revealToggle(animated: true)
            
        }
        else if indexPath.row == 2{
            //delegate?.selectedMenuItem(item: indexPath.row)
            //self.revealViewController().revealToggle(animated: true)
            
        }
        else{}
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
