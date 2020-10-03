//
//  commentViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/21.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class commentViewController: UIViewController {

    var postId:Int = 0
    @IBOutlet weak var commentTableVeiw: UITableView!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var tableAndBottom: NSLayoutConstraint!
    var commnetList:[String] = []
    var comment:[comment?] = []
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

    override func viewWillAppear(_ animated: Bool) {
        commentDataManager.shared.getGominDetail(self, postId: self.postId, pageNum: 0)
//        self.view.layoutIfNeeded()
    }
//    func setComment() {
//        print(self.comment)
//
//        self.view.setNeedsLayout()
//        self.view.setNeedsDisplay()
//    }

}
extension commentViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = commentTableVeiw.dequeueReusableCell(withIdentifier: "comment") as? commentTableViewCell else {
            return UITableViewCell()
        }
        let createdAt:String = (self.comment[indexPath.row]?.createdDate)!
        let createTime:String = createdAt.components(separatedBy: "T")[1]
        let time:[String] = createTime.components(separatedBy: ":")
        if Int(time[0])! > 12 {
            cell.ampm.text = "PM"
            let hour = Int(time[0])! - 12
            cell.time.text = String(hour) + ":" + time[1]
        }else{
            cell.ampm.text = "AM"
            cell.time.text =
                time[0] + ":" + time[1]
        }
        cell.comment.text = self.comment[indexPath.row]?.content
        cell.likeCount.text = String((self.comment[indexPath.row]?.commentLikes)!)
        cell.userName.text = self.comment[indexPath.row]?.nickname
//        cell.comment.text = commnetList[indexPath.row]
        return cell
    }
    
    
}
