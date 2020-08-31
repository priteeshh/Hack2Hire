//
//  DemoCell.swift
//  FoldingCell
//
//  Created by Alex K. on 25/12/15.
//  Copyright © 2015 Alex K. All rights reserved.
//

import FoldingCell
import UIKit

class DemoCell: FoldingCell {

    @IBOutlet var closeNumberLabel: UILabel!
    @IBOutlet var openNumberLabel: UILabel!
    @IBOutlet weak var orderDetailsBtn: RoundedGradientButton!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var PharmacyName: UILabel!
    
//    var number: Int = 0 {
//        didSet {
//            closeNumberLabel.text = String(number)
//            openNumberLabel.text = String(number)
//        }
//    }

    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        foregroundView.layer.borderColor = Theme.Color.accent.cgColor
        foregroundView.layer.borderWidth = 1
        
        foregroundView.layer.cornerRadius = 8
        
        foregroundView.layer.shadowOpacity = 0.1
        foregroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        super.awakeFromNib()
    }

    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}

// MARK: - Actions ⚡️

extension DemoCell {

    @IBAction func buttonHandler(_: AnyObject) {
        print("tap")

    }
}
