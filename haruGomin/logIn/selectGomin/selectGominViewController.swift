//
//  selectGominViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/19.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class selectGominViewController: UIViewController {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    var btnText:[String] = ["1","1","1","1","1","1","1","1","1"]
    var buttons:[UIButton] = []
    override func viewDidLoad() {
        self.infoView.backgroundColor = ColorPalette.borderGray
        super.viewDidLoad()
        makeBtns()
    }
    override func viewWillAppear(_ animated: Bool) {
        nextBtn.layer.cornerRadius = 8
        nextBtn.isEnabled = false
        nextBtn.backgroundColor = ColorPalette.borderGray
    }
    func makeBtns(){
        for i in 0...btnText.count - 1 {
            var btn = UIButton()
            buttons.append(btn)
            if i == 0{
                buttons[i] = UIButton(frame: CGRect(x: 20, y: 200, width: 72, height: 40))
            }else if i % 4 == 0 && i != 0{
                buttons[i] = UIButton(frame: CGRect(x: 20, y: buttons[i-4].bounds.maxY + 20, width: 72, height: 40))
            }else {
                buttons[i] = UIButton(frame: CGRect(x: buttons[i-1].bounds.maxX + 20, y: buttons[i-1].bounds.minY, width: 72, height: 40))
            }
            buttons[i].setTitle(btnText[i], for: .normal)
            buttons[i].layer.cornerRadius = 8
            buttons[i].layer.borderWidth = 1
            buttons[i].layer.borderColor = ColorPalette.borderGray.cgColor
            self.view.addSubview(buttons[i])
        }
    }


}
