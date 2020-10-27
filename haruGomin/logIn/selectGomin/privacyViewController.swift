//
//  privacyViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/27.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class privacyViewController: UIViewController {

    @IBOutlet weak var privacyText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = ColorPalette.darkBackground
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.topItem?.title = "이용약관 및 개인정보처리 방침"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white ]
        self.privacyText.textColor = .white
        self.view.backgroundColor = ColorPalette.background
        self.privacyText.backgroundColor = ColorPalette.background
        self.privacyText.isEditable = false
    }

}
