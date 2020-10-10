//
//  splash2ViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/10.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class splash2ViewController: UIViewController {

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
        self.img.image = UIImage(named: "illu3")
        self.img.contentMode = .scaleAspectFit
        self.text1.text = "걱정마세요!"
        self.text2.text = "24시간 후 글 자동 삭제로 고민이"
        self.text3.text = "새어나가지 않도록 비밀을 지켜드릴게요"
    }
    
    @IBAction func skip(_ sender: Any) {
        let loginVC = logInViewController()
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UINavigationController(rootViewController:loginVC)
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {}, completion: nil)
        } else {
            loginVC.modalPresentationStyle = .overFullScreen
            self
                .present(loginVC, animated: true, completion: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func prev(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func next(_ sender: Any) {
        let next = splash3ViewController()
        self.navigationController?.pushViewController(next, animated: true)
    }
}
