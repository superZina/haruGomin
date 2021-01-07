//
//  setProfileViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/12.
//  Copyright © 2020 이진하. All rights reserved.
//
import Kingfisher
import UIKit

class setProfileViewController: UIViewController,imgPopUpDelegate {
    
    

    var ages:[String] = ["1 ~ 9" , "10 ~ 19", "20 ~ 29", "30 ~ 39", "40 ~ 49"]
    var selectedAge:String = "1 ~ 9"
    var selectedImg:String = "default01"
    @IBOutlet weak var profileImg: UIButton!
    @IBOutlet weak var nickName: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    var profileIsUploaded:Bool = false
    
    
    var agePicker:UIPickerView! = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.view.backgroundColor = ColorPalette.background
        
        self.profileImg.backgroundColor = ColorPalette.darkBackground
        self.profileImg.layer.cornerRadius = 24
        self.profileImg.imageView?.layer.cornerRadius = 24
        
        self.nickName.layer.cornerRadius = 9
        self.nickName.layer.borderWidth = 1
        self.nickName.layer.borderColor = ColorPalette.borderGray.cgColor
        self.nickName.textColor = ColorPalette.textGray
        self.nickName.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요.",attributes: [NSAttributedString.Key.foregroundColor: ColorPalette.borderGray])
        
        self.age.layer.cornerRadius = 9
        self.age.layer.borderWidth = 1
        self.age.layer.borderColor = ColorPalette.borderGray.cgColor
        self.age.textColor = ColorPalette.textGray
        self.age.attributedPlaceholder = NSAttributedString(string: "연령을 선택해주세요.",attributes: [NSAttributedString.Key.foregroundColor: ColorPalette.borderGray])
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        self.nickName.addLeftPadding(imgName: "")
        self.age.addLeftPadding(imgName: "")
        
        self.age.delegate = self
        self.nickName.delegate = self
        
        agePicker.delegate = self
        agePicker.dataSource = self
        createAgePicker()
        self.nextBtn.layer.cornerRadius = 8
        self.nextBtn.backgroundColor = ColorPalette.borderGray
    }
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = ColorPalette.darkBackground
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                        NSAttributedString.Key.font: UIFont.medium20]
        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.topItem?.title = "프로필 설정"
        
        if self.nickName.text == "" || self.age.text == "" {
            self.nextBtn.isEnabled = false
        }else{
            self.nextBtn.isEnabled = true
            self.nextBtn.backgroundColor = ColorPalette.hagoRed
        }
    }
    
    @IBAction func selectImg(_ sender: Any) {
        let imgPopUpStoryboard = UIStoryboard(name: "imgPopUp", bundle: Bundle.main)
        guard let imgPopup = imgPopUpStoryboard
            .instantiateViewController(withIdentifier: "imgPopUp") as? imgPopUp else {
            return
        }
//        imgPopup.modalTransitionStyle = .full
        imgPopup.modalPresentationStyle = .overFullScreen
        imgPopup.imgPopupDelegate = self
        self.present(imgPopup, animated: true, completion: nil)
    }
    
    func pressDismissBtn(imgName:String) {
        self.selectedImg = imgName
        if let enc_url = imgName.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
            let url = URL(string: enc_url)
            let img = UIImageView()
            self.profileImg.kf.setImage(with: url, for: .normal)
            self.profileIsUploaded = true
        }
    }
    
    @IBAction func moveNext(_ sender: Any) {
        if self.profileIsUploaded {
            if nickName.text!.count > 8 {
                let alert = UIAlertController(title: "닉네임 오류", message: "닉네임 길이를 8자 이하로 설정해주세요!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }else{
        checkNameDataManager().check(self, name: nickName.text! , age: self.age.text! , imageNum: self.selectedImg)
            }
        }else{
            let alert = UIAlertController(title: "앗 프로필 사진이 없어요!", message: "프로필 사진을 설정해주세요!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func createAgePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneTimePressed))
        doneBtn.title = "확인"
        doneBtn.tintColor = ColorPalette.hagoRed
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexible,doneBtn], animated: true)
        toolbar.barTintColor = ColorPalette.darkBackground
        toolbar.isTranslucent = false
        toolbar.backgroundColor = ColorPalette.darkBackground
        age.inputAccessoryView = toolbar
        agePicker.backgroundColor = ColorPalette.darkBackground
        age.inputView = agePicker

    }
    @objc func doneTimePressed(){
        self.age.text = selectedAge
        self.view.endEditing(true)
    }
}



//MARK: EXTENSIONS
extension setProfileViewController:UIPickerViewDelegate, UIPickerViewDataSource , UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.ages.count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var ageLabel: UILabel
        ageLabel = UILabel()
        ageLabel.font = UIFont.boldSystemFont(ofSize: 18)
        ageLabel.textAlignment = .center
        ageLabel.text = ages[row]
        ageLabel.textColor = .white
        
        return ageLabel
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAge = ages[row]
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if self.nickName.text == "" || self.age.text == "" {
            self.nextBtn.isEnabled = false
            self.nextBtn.backgroundColor = ColorPalette.borderGray
        }else{
            self.nextBtn.isEnabled = true
            self.nextBtn.backgroundColor = ColorPalette.hagoRed
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if(string == "\n"){
                textField.resignFirstResponder()
            }
           return true
       
        }
}
