//
//  selectGominViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/19.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import AlignedCollectionViewFlowLayout

class selectGominViewController: UIViewController, UICollectionViewDataSource {
    var nickName:String = ""
    var age:String = ""
    var Img:String = ""
    @IBOutlet weak var gominCollection: UICollectionView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var privacyBtn: UIButton!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var text3: UILabel!
    
    var btnText:[String] = ["돈","일상","가족","건강","친구사이","직장생활","연애","학교생활","진로","기혼자만 아는","육아"]
    var buttons:[UIButton] = []
    override func viewDidLoad() {
        self.view.backgroundColor = ColorPalette.darkBackground
        self.infoView.backgroundColor = ColorPalette.borderGray
        
        self.text1.font = UIFont.textStyle2
        self.text2.font = UIFont.fontParagraph1Orange
        self.text3.font = UIFont.fontParagraph1Orange
        
        self.gominCollection.backgroundColor = ColorPalette.darkBackground
        super.viewDidLoad()
        let itemCellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.gominCollection.register(itemCellNib, forCellWithReuseIdentifier: "gomin")
        
        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        gominCollection.collectionViewLayout = layout
        self.gominCollection.delegate = self
        self.gominCollection.dataSource = self
      
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "고민선택"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                        NSAttributedString.Key.font: UIFont.medium20]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = ColorPalette.darkBackground
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
        
        if !self.privacyBtn.isSelected {
        nextBtn.layer.cornerRadius = 8
        nextBtn.isEnabled = false
        nextBtn.backgroundColor = ColorPalette.borderGray
        }else if self.privacyBtn.isSelected && self.buttons.count>=1 && self.buttons.count<4 {
            nextBtn.layer.cornerRadius = 8
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = ColorPalette.hagoRed
        }
    }

    @IBAction func moveNext(_ sender: Any) {
        var ageRange:Int32 = 0
        var hashTags:[String] = []
        let id:String = UserDefaults.standard.value(forKey: "userId") as! String
        let pw: String = UserDefaults.standard.value(forKey: "password") as! String
        
        switch self.age {
        case "1 ~ 9":
            ageRange = 1
        case "10 ~ 19":
            ageRange = 10
        case "20 ~ 29":
            ageRange = 20
        case "30 ~ 39":
            ageRange = 30
        case "40 ~ 49":
            ageRange = 40
        default:
            break
        }
        
        for i in buttons {
            hashTags.append(i.title(for: .normal)!)
        }
        let parameters:[String:Any] = [
            "ageRange" : ageRange,
            "nickname" : self.nickName,
            "password" : pw,
            "profileImage" : self.Img,
            "userhashtags" : hashTags ,
            "userLoginId" : id
        ]
        signUpDataManager().signUp(self, ageRange, nickName, pw, self.Img, hashTags, id)
    }
    
    @IBAction func agreeToPrivacyPolicy(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let policyVC = privacyViewController()
        self.navigationController?.pushViewController(policyVC, animated: true)
        if sender.isSelected {
            sender.setImage(UIImage(named: "pressed"), for: .normal)
            if self.buttons.count >= 1 && self.buttons.count < 4 {
                self.nextBtn.isEnabled = true
                self.nextBtn.backgroundColor = ColorPalette.hagoRed
            }
        }else{
            sender.setImage(UIImage(named: "normal"), for: .normal)
            self.nextBtn.isEnabled = false
            self.nextBtn.backgroundColor = ColorPalette.borderGray
        }
    }
}


extension selectGominViewController:UICollectionViewDelegateFlowLayout{
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
        if buttons.count >= 0 && buttons.count<4 && self.privacyBtn.isSelected {
            self.nextBtn.isEnabled = true
            self.nextBtn.backgroundColor = ColorPalette.hagoRed
        }else {
            self.nextBtn.isEnabled = false
            self.nextBtn.backgroundColor = ColorPalette.borderGray
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (btnText[indexPath.item] as! NSString).size(withAttributes: nil).width
        return CGSize(width: size + 40, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 10 , left: 5, bottom: 0, right: 5)
        }
    
}
