//
//  noticeViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/22.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class noticeViewController: UIViewController {

    var notice:[String] = ["고민에 답글이 달렸어요","3명이 하고 님이 쓴 댓글을 좋아해요","축하해요! 하고 님이 작성한 댓글이 베스트 댓글로 선정되었어요!"]
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var noticeTable: UITableView!
    @IBOutlet weak var adImg: UIImageView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        switch(UIScreen.main.nativeBounds.height) {
        case 1334: //se2 , 8
            navHeight.constant = 70
            break
        case 2688: //promax
            
            break
        case 2436: //pro
            
            break
        case 1792: //1
            
            break
        case 2208: //8+
            navHeight.constant = 60
            break
        default:
            break
        }
        
        
        
        self.navView.backgroundColor = ColorPalette.darkBackground
        self.view.backgroundColor = ColorPalette.background
        
        let noticeCellNib = UINib(nibName: "noticeTableViewCell", bundle: nil)
        self.noticeTable.register(noticeCellNib, forCellReuseIdentifier: "notice")
        self.noticeTable.delegate = self
        self.noticeTable.dataSource = self
        self.noticeTable.backgroundColor = ColorPalette.background
        self.noticeTable.separatorColor = UIColor(red: 83/255, green: 89/255, blue: 116/255, alpha: 1)
        
        self.adImg.layer.cornerRadius = 16
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
       
    }
}
extension noticeViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = noticeTable.dequeueReusableCell(withIdentifier: "notice", for: indexPath) as! noticeTableViewCell
        cell.noticeComment.text = notice[indexPath.row]
        
        return cell
    }
     
    
}
