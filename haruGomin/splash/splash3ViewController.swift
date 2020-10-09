//
//  splash3ViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/10.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class splash3ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var text3: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorPalette.background
        self.nextBtn.backgroundColor = ColorPalette.hagoRed
        self.nextBtn.setTitleColor(ColorPalette.darkBackground, for: .normal)
        self.nextBtn.layer.cornerRadius = 8
        self.img.image = UIImage(named: "illu4")
        self.img.contentMode = .scaleAspectFit
        self.text1.text = "더 많은 이들과 함께"
        self.text2.text = "더 많은 의견을 나누고"
        self.text3.text = "고민을 해결해보세요!"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func prev(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
