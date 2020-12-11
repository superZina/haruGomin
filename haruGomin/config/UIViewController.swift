//
//  UIViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/12/11.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

extension UIViewController{
    func presentAlert(title: String? , message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
