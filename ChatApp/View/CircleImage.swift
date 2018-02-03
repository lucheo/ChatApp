//
//  CircleImage.swift
//  ChatApp
//
//  Created by Lucheo Tombini Filho on 02/02/18.
//  Copyright © 2018 Lucheo Tombini Filho. All rights reserved.
//

import UIKit
@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
