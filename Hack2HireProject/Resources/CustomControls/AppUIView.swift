//
//  AppUIView.swift
//  DBSSample
//
//  Created by Preeteesh Remalli on 16/07/19.
//  Copyright © 2019 Preeteesh Remalli. All rights reserved.
//

import UIKit

class AppUIView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.borderColor = Theme.Color.accent.cgColor
        layer.borderWidth = 1
        
        layer.cornerRadius = 8
        
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 3)
    }
}

