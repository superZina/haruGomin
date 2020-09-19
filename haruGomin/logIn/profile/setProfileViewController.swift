//
//  setProfileViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/12.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class setProfileViewController: UIViewController {

    var ages:[String] = ["1 ~ 9" , "10 ~ 19", "20 ~ 29", "30 ~ 39", "40 ~ 49"]
    var selectedAge:String = "1 ~ 9"
    @IBOutlet weak var profileImg: UIButton!
    @IBAction func selectImg(_ sender: Any) {
    }
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
        
        self.nickName.layer.cornerRadius = 9
        self.nickName.layer.borderWidth = 1
        self.nickName.layer.borderColor = ColorPalette.borderGray.cgColor
        self.nickName.textColor = ColorPalette.borderGray
        self.nickName.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요.",attributes: [NSAttributedString.Key.foregroundColor: ColorPalette.borderGray])
        
        self.age.layer.cornerRadius = 9
        self.age.layer.borderWidth = 1
        self.age.layer.borderColor = ColorPalette.borderGray.cgColor
        self.age.textColor = ColorPalette.borderGray
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
    
    @IBAction func moveNext(_ sender: Any) {
        let selectVC = selectGominViewController()
        self.navigationController?.pushViewController(selectVC, animated: true)
    }
    func createAgePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneTimePressed))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexible,doneBtn], animated: true)
        age.inputAccessoryView = toolbar
        agePicker.backgroundColor = ColorPalette.darkBackground
        age.inputView = agePicker

    }
    @objc func doneTimePressed(){
        self.age.text = selectedAge
        self.view.endEditing(true)
    }
}

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
}
