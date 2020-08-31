//
//  PlaceMyOrderVCViewController.swift
//  Hack2HireProject
//
//  Created by Preeteesh Remalli on 20/07/19.
//  Copyright © 2019 Preeteesh Remalli. All rights reserved.
//

import UIKit

class PlaceMyOrderVCViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var orbitImageView: UIImageView!
    @IBOutlet weak var innerOrbitImageView: UIImageView!
    @IBOutlet weak var medicinCollectionView: UICollectionView!
    @IBOutlet weak var fileImageView: UIImageView!
    var imagePicker = UIImagePickerController()
    
    var picker = UIImagePickerController();
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?;


    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]

    override func viewDidLoad() {
        super.viewDidLoad()
        medicinCollectionView.delegate = self
        medicinCollectionView.dataSource = self
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = medicinCollectionView.dequeueReusableCell(withReuseIdentifier: "medicinCell", for: indexPath as IndexPath) as! PlaceOrderCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.medicinLabel.text = "Medicin" + self.items[indexPath.item]
        //cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    @IBAction func uploadButtonTapped(_ sender: Any) {
//        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
//            print("Button capture")
//
//            imagePicker.delegate = self
//            imagePicker.sourceType = .savedPhotosAlbum
//            imagePicker.allowsEditing = false
//
//            present(imagePicker, animated: true, completion: nil)
//        }
        ImagePickerManager().pickImage(self){ image in
            //here is the image
            self.fileImageView.image = image
            self.fileImageView.contentMode = .scaleAspectFit
        }
        
    }

 
    @IBAction func ReviewandProceedtoPayment(_ sender: Any) {
        
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


