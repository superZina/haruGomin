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
    
    
    var agePicker:UIPickerView! = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = ColorPalette.darkBackground
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.topItem?.title = "프로필 설정"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white ]

        
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
        
        
        self.nickName.addLeftPadding()
        self.age.addLeftPadding()
        
        self.age.delegate = self
        self.nickName.delegate = self
        
        agePicker.delegate = self
        agePicker.dataSource = self
        createAgePicker()
        
        self.nextBtn.layer.cornerRadius = 8
        self.nextBtn.backgroundColor = ColorPalette.borderGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
//            img.kf.setImage(with: <#T##Source?#>)
            self.profileImg.kf.setImage(with: url, for: .normal)
        }
        
        
    }
    @IBAction func moveNext(_ sender: Any) {
        checkNameDataManager().check(self, name: nickName.text! , age: self.age.text! , imageNum: self.selectedImg)
//        let selectVC = selectGominViewController()
//        self.navigationController?.pushViewController(selectVC, animated: true)
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
