//
//  signInViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/12/11.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import SnapKit


class signInViewController: UIViewController {
    
    @IBOutlet weak var welcomText: UILabel!
    @IBOutlet weak var idTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var securityBtn: UIButton!
    var isOk:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorPalette.background
        
        self.idTextfield.delegate = self
        self.passwordTextfield.delegate = self
        
        self.welcomText.font = UIFont.medium24
        self.signUpBtn.titleLabel?.font = UIFont.fontEngNumber4
        self.signUpBtn.setTitleColor(ColorPalette.textGray, for: .normal)
        
        self.idTextfield.setborder()
        self.idTextfield.addLeftPadding(imgName: "iconMySmall")
        self.passwordTextfield.setborder()
        self.passwordTextfield.addLeftPadding(imgName: "iconPassword")
        self.idTextfield.setplacehoderText(text: "아이디를 입력해주세요.")
        self.passwordTextfield.setplacehoderText(text: "비밀번호를 입력해주세요.")
        
        
        //        button.snp.makeConstraints { (make) in
        //            make.leading.equalTo(passwordTextfield.snp.trailing)
        //        }
        //        passwordTextfield.addSubview(button)
        //        passwordTextfield.isSecureTextEntry = false
        
        self.loginBtn.layer.cornerRadius = 8
        self.loginBtn.backgroundColor = ColorPalette.borderGray
        self.loginBtn.titleLabel?.font = UIFont.fontButtonWhite
        self.loginBtn.setTitleColor(ColorPalette.textGray, for: .normal)
        self.loginBtn.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.medium20]
        self.navigationController?.navigationBar.topItem?.title = "로그인"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = ColorPalette.darkBackground
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
    }
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        let signUpVC = signUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func signIn(_ sender: Any) {
        if let id = self.idTextfield.text , let password = self.passwordTextfield.text {
            signInDataManager.shared.signIn(self, id, password)
        }else {
            self.presentAlert(title: "아이디 또는 비밀번호를 입력해 주세요!", message: "확인")
        }
    }
    
    
    @IBAction func passwordVisibility(_ sender : UIButton) {
        
        if sender.isSelected {
            passwordTextfield.isSecureTextEntry = false
            sender.setImage(UIImage(named: "iconVisibility"), for: .normal)
        }else{
            passwordTextfield.isSecureTextEntry = true
            sender.setImage(UIImage(named: "iconVisibilityOff"), for: .normal)
        }
        sender.isSelected = !sender.isSelected
    }
    
}

extension signInViewController : UITextFieldDelegate {
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //        if textField == passwordTextfield {
    //            guard  let text = textField.text else {
    //                return true
    //            }
    //            let newLenght = text.count + string.count - range.length
    //            return newLenght <= 21
    //        }
    //        return false
    //    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextfield {
            passwordTextfield.becomeFirstResponder()
        }else{
            self.view.endEditing(true)
        }
        return false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if idTextfield.text != "" && passwordTextfield.text != "" {
//            self.isOk = true
//            if self.isOk {
//                self.loginBtn.isEnabled = true
//                self.loginBtn.backgroundColor = ColorPalette.hagoRed
//                self.loginBtn.setTitleColor(ColorPalette.darkBackground, for: .normal)
//            }
//        }else {
//            self.isOk = false
//            self.loginBtn.isEnabled = false
//            self.loginBtn.backgroundColor = ColorPalette.borderGray
//            self.loginBtn.setTitleColor(ColorPalette.textGray, for: .normal)
//        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if idTextfield.text != "" && passwordTextfield.text != "" {
            self.isOk = true
            if self.isOk {
                self.loginBtn.isEnabled = true
                self.loginBtn.backgroundColor = ColorPalette.hagoRed
                self.loginBtn.setTitleColor(ColorPalette.darkBackground, for: .normal)
                return true
            }
        }else {
            self.isOk = false
            self.loginBtn.isEnabled = false
            self.loginBtn.backgroundColor = ColorPalette.borderGray
            self.loginBtn.setTitleColor(ColorPalette.textGray, for: .normal)
            return true
        }
        return false
    }
}
