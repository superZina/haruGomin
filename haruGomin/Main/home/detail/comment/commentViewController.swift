//
//  commentViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/21.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class commentViewController: UIViewController {

    @IBOutlet weak var commentTableVeiw: UITableView!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var tableAndBottom: NSLayoutConstraint!
    var commnetList:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 8
        commnetList = ["asdfasdf","dfsfllflelfllflflflflflflflflflflflflflflflfllfflfllfflflfllflflflflflfl","kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk","저도 얼마 전에 비슷한 상황이었어요. 힘들다는 생각말고 그냥 지금 할 수 있는 걸 하다보면 자신감도 생기고 길이 보이더라고요! 분명 원하는 일 하실 수 있을거에요! 모두 화이팅이요 :)"]
        self.handleArea.backgroundColor = ColorPalette.darkBackground
        self.view.backgroundColor = ColorPalette.darkBackground
        let cellNib = UINib(nibName: "commentTableViewCell", bundle: nil)
        self.commentTableVeiw.delegate = self
        self.commentTableVeiw.dataSource = self
        self.commentTableVeiw.register(cellNib, forCellReuseIdentifier: "comment")
        self.commentTableVeiw.backgroundColor = ColorPalette.darkBackground
        print(self.view.bounds.height)
        switch(UIScreen.main.nativeBounds.height) {
        case 1334: //se2 , 8
            tableAndBottom.constant = 100
            break
        case 2688: //promax
            tableAndBottom.constant = 250
            break
        case 2436: //pro
            tableAndBottom.constant = 270
            break
        case 1792: //11
            tableAndBottom.constant = 300
            break
        case 2208: //8+
            tableAndBottom.constant = 260
            break
        default:
            break
        }
    }


}
extension commentViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commnetList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = commentTableVeiw.dequeueReusableCell(withIdentifier: "comment") as? commentTableViewCell else {
            return UITableViewCell()
        }
        cell.comment.text = commnetList[indexPath.row]
        return cell
    }
    
    
}
