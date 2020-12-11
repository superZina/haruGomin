//
//  UITextField.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/17.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

extension UITextField {
    func addLeftPadding(imgName: String?) {
        var width = 44
        var height = 24
        var xpadding = 10
        if imgName == "" {
            width = 10
            height = 10
            xpadding = 0
        }
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        let icon:UIImageView = UIImageView(frame: CGRect(x: xpadding, y: 0, width: 24, height: 24))
        icon.image = UIImage(named: imgName!)
        paddingView.addSubview(icon)
        self.leftViewMode = .always
        self.leftView = paddingView
    }
    func setborder(){
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = ColorPalette.borderGray.cgColor
    }
    func setplacehoderText(text: String?) {
        if let placeholder = text {
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: ColorPalette.textGray,NSAttributedString.Key.font: UIFont.fontEngNumber3White])
        }
    }
    
   
}
