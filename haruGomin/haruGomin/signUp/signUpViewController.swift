//
//  signUpViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/12/11.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class signUpViewController: UIViewController {
    
    @IBOutlet weak var idTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var cornfirmTextfield: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var welcomText: UILabel!
    @IBOutlet weak var warnText: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    var textfields:[UITextField] = []
    var isOk:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textfields = [idTextfield, passwordTextfield , cornfirmTextfield]
        
        
        self.view.backgroundColor = ColorPalette.background
        
        self.welcomText.font = UIFont.medium24
        self.warnText.font = UIFont.notoRegular10
        self.warnText.textColor = ColorPalette.textGray
        self.signUpBtn.titleLabel?.font = UIFont.fontButtonWhite
        self.signUpBtn.setTitleColor(ColorPalette.textGray, for: .normal)
        self.signUpBtn.backgroundColor = ColorPalette.borderGray
        self.signUpBtn.layer.cornerRadius = 8
        self.signUpBtn.isEnabled = false
        
        self.idTextfield.delegate = self
        self.passwordTextfield.delegate = self
        self.cornfirmTextfield.delegate = self
        self.idTextfield.setborder()
        self.idTextfield.addLeftPadding(imgName: "iconMySmall")
        self.idTextfield.setplacehoderText(text: "아이디를 입력해주세요.")
        self.passwordTextfield.setborder()
        self.passwordTextfield.addLeftPadding(imgName: "iconPassword")
        self.passwordTextfield.setplacehoderText(text: "비밀번호를 입력해주세요.")
        self.cornfirmTextfield.setborder()
        self.cornfirmTextfield.addLeftPadding(imgName: "iconPassword")
        self.cornfirmTextfield.setplacehoderText(text: "비밀번호를 확인해주세요.")
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                        NSAttributedString.Key.font: UIFont.medium20]
        self.navigationController?.navigationBar.topItem?.title = "회원가입"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = ColorPalette.darkBackground
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
    }
    
    @IBAction func check(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setImage(UIImage(named: "iconDonePressed"), for: .normal)
            if isOk {
                self.signUpBtn.isEnabled = true
                self.signUpBtn.backgroundColor = ColorPalette.hagoRed
                self.signUpBtn.setTitleColor(ColorPalette.darkBackground, for: .normal)
            }
        }else {
            sender.setImage(UIImage(named: "iconDoneNormal"), for: .normal)
            self.signUpBtn.isEnabled = false
            self.signUpBtn.backgroundColor = ColorPalette.borderGray
            self.signUpBtn.setTitleColor(ColorPalette.textGray, for: .normal)
        }
    }
    @IBAction func signUp(_ sender: Any) {
        if !isOk {
                let alert = UIAlertController(title: "회원정보 오류", message: "회원정보를 모두 입력해주세요!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .cancel)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
        }else if passwordTextfield.text != cornfirmTextfield.text {
            let alert = UIAlertController(title: "비밀번호 오류", message: "비밀번호를 확인해주세요!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }else if let id = idTextfield.text , let pw = passwordTextfield.text{
            if id.isValidID(id) {
                checkIdDataManager.shared.checkID(signUpVC: self, id: id , pw : pw)
            }else{
                let alert = UIAlertController(title: "아이디 오류", message: "아이디는 영문,숫자 조합 2~64자 이내로 입력해주세요!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .cancel)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    
    @IBAction func passwordVisibility(_ sender : Any) {
        
        if (sender as! UIButton).isSelected {
            passwordTextfield.isSecureTextEntry = false
            (sender as! UIButton).setImage(UIImage(named: "iconVisibility"), for: .normal)
        }else{
            passwordTextfield.isSecureTextEntry = true
            (sender as! UIButton).setImage(UIImage(named: "iconVisibilityOff"), for: .normal)
        }
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
    }
    
    @IBAction func confirmVisibility(_ sender : Any) {
        
        if (sender as! UIButton).isSelected {
            cornfirmTextfield.isSecureTextEntry = false
            (sender as! UIButton).setImage(UIImage(named: "iconVisibility"), for: .normal)
        }else{
            cornfirmTextfield.isSecureTextEntry = true
            (sender as! UIButton).setImage(UIImage(named: "iconVisibilityOff"), for: .normal)
        }
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
    }
    
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    
}


extension signUpViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextfield {
            passwordTextfield.becomeFirstResponder()
        }else if textField == passwordTextfield {
            cornfirmTextfield.becomeFirstResponder()
        }else{
            self.view.endEditing(true)
        }
        return false
    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if idTextfield.text != "" && passwordTextfield.text != "" && cornfirmTextfield.text != "" {
//            self.isOk = true
//            if self.isOk && self.checkBtn.isSelected {
//                self.signUpBtn.isEnabled = true
//                self.signUpBtn.backgroundColor = ColorPalette.hagoRed
//                self.signUpBtn.setTitleColor(ColorPalette.darkBackground, for: .normal)
//            }
//        }else {
//            self.isOk = false
//            self.signUpBtn.isEnabled = false
//            self.signUpBtn.backgroundColor = ColorPalette.borderGray
//            self.signUpBtn.setTitleColor(ColorPalette.textGray, for: .normal)
//        }
//    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if idTextfield.text != "" && passwordTextfield.text != "" && cornfirmTextfield.text != "" {
            self.isOk = true
            if self.isOk {
                self.signUpBtn.isEnabled = true
                self.signUpBtn.backgroundColor = ColorPalette.hagoRed
                self.signUpBtn.setTitleColor(ColorPalette.darkBackground, for: .normal)
                return true
            }
        }else {
            self.isOk = false
            self.signUpBtn.isEnabled = false
            self.signUpBtn.backgroundColor = ColorPalette.borderGray
            self.signUpBtn.setTitleColor(ColorPalette.textGray, for: .normal)
            return true
        }
        return false
    }
}
