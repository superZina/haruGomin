//
//  setProfileViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/12.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class setProfileViewController: UIViewController {

    @IBOutlet weak var profileImg: UIButton!
    @IBAction func selectImg(_ sender: Any) {
    }
    @IBOutlet weak var nickName: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
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
        
        self.nextBtn.layer.cornerRadius = 8
        self.nextBtn.backgroundColor = ColorPalette.borderGray
    }

}
