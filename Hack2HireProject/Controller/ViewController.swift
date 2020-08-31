//
//  ViewController.swift
//  DBSSample
//
//  Created by Preeteesh Remalli on 15/07/19.
//  Copyright © 2019 Preeteesh Remalli. All rights reserved.
//

import UIKit
import FoldingCell
import SwiftyJSON



class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var customerID = ""
    var ordersArray : [Orders] = []
    enum Const {
        static let closeCellHeight: CGFloat = 179
        static let openCellHeight: CGFloat = 488
        static let rowsCount = 10
    }
    
    var cellHeights: [CGFloat] = []
    

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var orbitImageView: UIImageView!
    @IBOutlet weak var innerOrbitImageView: UIImageView!
    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        customerID = UserDefaults.standard.string(forKey: "customerid")!
         menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        setup()
        callOrderDetails()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func callOrderDetails(){
        
            let url = URL(string: "https://my.api.mockaroo.com/orders.json?key=0f0334b0")!
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print("request failed \(error.debugDescription)")
                    return
                }
                do {
                    let results = try JSON(data: data)
                    let json = results.arrayValue
                    //ordersArray = json
                    for  var eachResult in json{
                        let customerId = eachResult["customerId"].stringValue
                        let orderStatus = eachResult["orderStatus"].stringValue
                        let documentId = eachResult["documentId"].stringValue
                        let orderDate = eachResult["orderDate"].stringValue
                        let orderId = eachResult["orderId"].stringValue
                        let totalAmount = eachResult["totalAmount"].stringValue
                       
                        let order = Orders(customerId: customerId, orderStatus: orderStatus, documentId: documentId, orderDate: orderDate, orderId: orderId, totalAmount: totalAmount)
                        self.ordersArray.append(order)
                    }
                   print(self.ordersArray)
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                    }
                
                    
                } catch let parseError {
                    print("parsing error: \(parseError)")
                }
            }
            task.resume()
        
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //titleLbl.text = self.user?.username
        // Animate orbits to slowly rotate
        orbitImageView.startRotating(duration: 25, clockwise: false, delay: 1)
        innerOrbitImageView.startRotating(duration: 20, clockwise: true, delay: 1)
    }

    
    private func setup() {
        cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
        tableView.estimatedRowHeight = Const.closeCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        if #available(iOS 10.0, *) {
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        }
    }
    
    // MARK: Actions
    @objc func refreshHandler() {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            if #available(iOS 10.0, *) {
                self?.tableView.refreshControl?.endRefreshing()
            }
            self?.tableView.reloadData()
        })
    }
}
extension ViewController {
    
     func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return ordersArray.count
    }
    
     func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as DemoCell = cell else {
            return
        }
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        cell.orderDetailsBtn.tag = indexPath.row
        cell.closeNumberLabel.text =  ordersArray[indexPath.row].orderId
        cell.openNumberLabel.text =  ordersArray[indexPath.row].orderId
        cell.orderTime.text = ordersArray[indexPath.row].orderDate

        cell.status.text = ordersArray[indexPath.row].orderStatus
      
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
    }
    
     func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            
            // fix https://github.com/Ramotion/folding-cell/issues/169
            if cell.frame.maxY > tableView.frame.maxY {
                tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }
        }, completion: nil)
    }
}
