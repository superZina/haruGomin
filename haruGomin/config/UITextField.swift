//
//  UITextField.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/17.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.leftViewMode = .always
        self.leftView = paddingView
    }
}
