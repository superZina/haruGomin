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
    var pageNum:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 8
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
            tableAndBottom.constant = 150
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
        self.pageNum = 0
        commentDataManager.shared.getGominDetail(self, postId: self.postId, pageNum: self.pageNum)
//        self.view.layoutIfNeeded()
    }


}
extension commentViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = commentTableVeiw.dequeueReusableCell(withIdentifier: "comment") as? commentTableViewCell else {
            return UITableViewCell()
        }
        //베스트 댓글일 떄
        if (self.comment[indexPath.row]?.commentLikes)! >= 10 {
            cell.isBest = true
            cell.additionLabel.isHidden = false
        // TODO: postId -> userId로 바꿔줘야함
        }else if (self.comment[indexPath.row]?.userId)! == postId {
            cell.additionLabel.isHidden = true
            let label = UILabel(frame: CGRect(x: 12, y: 10, width: 64, height: 24))
            label.textColor = ColorPalette.hagoRed
            label.text = "작성자"
            label.font = .boldSystemFont(ofSize: 14)
            label.layer.borderWidth = 1
            label.layer.borderColor = ColorPalette.hagoRed.cgColor
            cell.innerView.addSubview(label)
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
        cell.likeCount.text = String( (self.comment[indexPath.row]?.commentLikes)!)
        
        cell.like.tag = (comment[indexPath.row]?.commentId)!
        cell.like.addTarget(self, action: #selector(likeComment(_:)), for: .touchUpInside)
        cell.profileImg.image = UIImage(named:(self.comment[indexPath.row]?.profileImage)! )
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height:CGFloat = scrollView.frame.size.height
        let contentYOffset:CGFloat = scrollView.contentOffset.y
        let scrollViewHeight:CGFloat = scrollView.contentSize.height
        let distanceFromBottom:CGFloat = scrollViewHeight - contentYOffset
        
        if distanceFromBottom < height {
            self.pageNum = self.pageNum + 1
            commentDataManager.shared.getGominDetail(self, postId: self.postId, pageNum: self.pageNum)
            print("DEBUG: listCount is \(self.comment.count)")
        }
        
    }
    
    @objc func likeComment(_ sendr:UIButton) {
        let userId:Int64 = UserDefaults.standard.value(forKey: "userId") as! Int64
        print("DEBUG: commentID is \(sendr.tag)")
        commentLikeDataManager.shared.likeComment(commentVC: self, commentID: sendr.tag, userId: userId)
        commentDataManager.shared.getGominDetail(self, postId: self.postId, pageNum: self.pageNum)
        
    }
    
    
}
