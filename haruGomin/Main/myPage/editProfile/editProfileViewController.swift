//
//  editProfileViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/09.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class editProfileViewController: UIViewController, UICollectionViewDataSource, imgPopUpDelegate {
    
    

    @IBOutlet weak var profileImg: UIButton!
    @IBOutlet weak var nickName: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var gominCollection: UICollectionView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var editBtn2: UIButton!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var text3: UILabel!
    
    var agePicker:UIPickerView! = UIPickerView()
    var btnText:[String] = ["돈","일상","가족","건강","친구사이","직장생활","연애","학교생활","진로","기혼자만 아는","육아"]
    var ages:[String] = ["1 ~ 9" , "10 ~ 19", "20 ~ 29", "30 ~ 39", "40 ~ 49"]
    var selectedAge:String = "1 ~ 9"
    var buttons:[UIButton] = []
    var userName:String = ""
    var ageRange:Int = 0
    var ImgNum:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = ColorPalette.darkBackground
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.topItem?.title = "프로필 수정"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white ]
        
        let imageNum:String = UserDefaults.standard.value( forKey: "profileImage") as! String
        self.profileImg.setImage(UIImage(named: imageNum), for: .normal)
        self.profileImg.imageView?.layer.cornerRadius = 24
        
        self.view.backgroundColor = ColorPalette.background
        self.gominCollection.backgroundColor = ColorPalette.background
        self.editBtn.layer.cornerRadius = 8
        self.editBtn.setTitleColor(ColorPalette.darkBackground, for: .normal)
        
        self.userName = UserDefaults.standard.value(forKey: "userName") as! String
        self.ageRange = UserDefaults.standard.value(forKey: "ageRange") as! Int
        self.ImgNum =  UserDefaults.standard.value(forKey: "profileImage") as! String

        
        self.nickName.text = self.userName
        self.nickName.layer.cornerRadius = 9
        self.nickName.layer.borderWidth = 1
        self.nickName.layer.borderColor = ColorPalette.borderGray.cgColor
        self.nickName.textColor = ColorPalette.textGray
        self.nickName.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요.",attributes: [NSAttributedString.Key.foregroundColor: ColorPalette.borderGray])
        
        self.age.text = String(self.ageRange)
        self.age.layer.cornerRadius = 9
        self.age.layer.borderWidth = 1
        self.age.layer.borderColor = ColorPalette.borderGray.cgColor
        self.age.textColor = ColorPalette.textGray
        self.age.attributedPlaceholder = NSAttributedString(string: "연령을 선택해주세요.",attributes: [NSAttributedString.Key.foregroundColor: ColorPalette.borderGray])
        
        // MARK: font
        self.editBtn2.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Regular", size: 14)
        self.text1.font = UIFont(name: "NotoSansCJKkr-Medium", size: 20)
        self.text2.font = UIFont(name: "NotoSansCJKkr-Medium", size: 20)
        self.text3.font = UIFont(name: "NotoSansCJKkr-Medium", size: 20)
        self.nickName.font = UIFont(name: "NotoSansCJKkr-Regular", size: 16)
        self.age.font = UIFont(name: "NotoSansCJKkr-Regular", size: 16)
        self.editBtn.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 18)
        
        self.age.delegate = self
        self.nickName.delegate = self
        agePicker.delegate = self
        agePicker.dataSource = self
        self.nickName.addLeftPadding()
        self.age.addLeftPadding()
        createAgePicker()
        
        let itemCellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.gominCollection.register(itemCellNib, forCellWithReuseIdentifier: "gomin")
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        gominCollection.collectionViewLayout = layout
        self.gominCollection.delegate = self
        self.gominCollection.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.nickName.text == "" || self.age.text == "" {
            self.editBtn.isEnabled = false
        }else{
            self.editBtn.isEnabled = true
            self.editBtn.backgroundColor = ColorPalette.hagoRed
        }
    }

    @IBAction func editProfile(_ sender: Any) {
        var hashTags:[String] = []
        for i in buttons {
            hashTags.append(i.title(for: .normal)!)
        }
        let id:Int64 = UserDefaults.standard.value(forKey: "userId") as! Int64
        let parameters:[String:Any] = [
            "ageRange" : self.age.text,
            "nickname" : self.nickName.text,
            "profileImage" : self.ImgNum,
            "userHashtags" : hashTags ,
            "userId" : id
        ]
        editProfileDataManager.shared.editProfile(self, parameter: parameters)
    }
    @IBAction func editProfileImg(_ sender: Any) {
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
    func pressDismissBtn(imgName: String) {
        self.ImgNum = imgName
        self.profileImg.setImage(UIImage(named: imgName), for: .normal)
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
extension editProfileViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.btnText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gominCollection.dequeueReusableCell(withReuseIdentifier: "gomin", for: indexPath) as! CollectionViewCell
        cell.contentView.backgroundColor = .none
        cell.btn.layer.cornerRadius = 8
        cell.btn.layer.borderWidth = 1
        cell.btn.layer.borderColor = ColorPalette.borderGray.cgColor
        cell.btn.setTitle(btnText[indexPath.item], for: .normal)
        cell.btn.setTitleColor(ColorPalette.textGray, for: .normal)
        
        cell.btn.addTarget(self, action: #selector(selected(sender:)), for: .touchUpInside)
        return cell
    }
    @objc func selected(sender: UIButton){
        sender.isSelected = !sender.isSelected
        sender.adjustsImageWhenHighlighted = false;
        if sender.isSelected {
            sender.layer.borderColor = ColorPalette.hagoRed.cgColor
            sender.setTitleColor(ColorPalette.hagoRed, for: .normal)
            buttons.append(sender)
        }else {
            sender.layer.borderColor = ColorPalette.borderGray.cgColor
            sender.setTitleColor(ColorPalette.textGray, for: .normal)
            for i in 0...buttons.count - 1 {
                if buttons[i] == sender {
                    buttons.remove(at: i)
                    break
                }
            }
        }
        if buttons.count != 0 {
            self.editBtn.isEnabled = true
            self.editBtn.backgroundColor = ColorPalette.hagoRed
        }else {
            self.editBtn.isEnabled = false
            self.editBtn.backgroundColor = ColorPalette.borderGray
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (btnText[indexPath.item] as! NSString).size(withAttributes: nil).width
        return CGSize(width: size + 40, height: 40)
    }
}

extension editProfileViewController:UIPickerViewDelegate, UIPickerViewDataSource , UITextFieldDelegate {
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
            self.editBtn.isEnabled = false
            self.editBtn.backgroundColor = ColorPalette.borderGray
        }else{
            self.editBtn.isEnabled = true
            self.editBtn.backgroundColor = ColorPalette.hagoRed
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if(string == "\n"){
                textField.resignFirstResponder()
            }
           return true
       
        }
    
}
