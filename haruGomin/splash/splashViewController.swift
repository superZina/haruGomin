//
//  splashViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/10.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import Lottie

class splashViewController: UIViewController{

    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var text3: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var img: UIImageView!
    var imgs:[String] = ["illu22", "illu3" , "illu4"]
    let animationView = AnimationView(name: "1page")
    override func viewDidLoad() {
        
        UserDefaults.standard.setValue(true, forKey: "second")
        super.viewDidLoad()
        self.view.backgroundColor = ColorPalette.background
        self.nextBtn.backgroundColor = ColorPalette.hagoRed
        self.nextBtn.setTitleColor(ColorPalette.darkBackground, for: .normal)
        self.nextBtn.layer.cornerRadius = 8
        
        self.img.addSubview(animationView)
        
        self.img.contentMode = .scaleAspectFill
        self.text1.text = "누구나 공감받을 수 있도록"
        self.text2.text = "비슷한 고민을 가진 이들에게"
        self.text3.text = "고민을 나눌 수 있어요"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        animationView.play()
        animationView.loopMode = .loop
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
    @IBAction func next(_ sender: Any) {
        let next = splash2ViewController()
        self.navigationController?.pushViewController(next, animated: true)
    }
}
