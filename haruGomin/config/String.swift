//
//  UIString.swift
//  haruGomin
//
//  Created by 이진하 on 2020/12/11.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

extension String {
    func isValidID(_ id: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: id)
    }
    
    func isValidPW(_ pw: String) -> Bool {
        let pwRegEx = "(?=.*[A-Za-z])(?=.*[0-9]).{8,20}"

        let pwPred = NSPredicate(format:"SELF MATCHES %@", pwRegEx)
        return pwPred.evaluate(with: pw)
    }
}
