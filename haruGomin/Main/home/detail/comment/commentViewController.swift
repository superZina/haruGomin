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
    var isWriter:[Bool] = []
    var pageNum:Int = 0
    var userId:Int64 = 0
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
        let userId:Int64 = UserDefaults.standard.value(forKey: "userId") as! Int64
        commentDataManager.shared.getGominDetail(self, postId: self.postId, pageNum: self.pageNum , userId: userId)
//        self.view.layoutIfNeeded()
    }


}
var comments:[commentTableViewCell] = []
extension commentViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.comment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = commentTableVeiw.dequeueReusableCell(withIdentifier: "comment") as? commentTableViewCell else {
            return UITableViewCell()
        }
        //베스트 댓글일 떄
        if comment[indexPath.row]?.userId == self.userId {
            cell.additionLabel.backgroundColor = ColorPalette.background
            cell.additionLabel.layer.borderColor = ColorPalette.hagoRed.cgColor
            cell.additionLabel.layer.borderWidth = 1
            cell.additionLabel.setTitle("작성자", for: .normal)
            cell.additionLabel.setTitleColor(ColorPalette.hagoRed, for: .normal)
            cell.additionLabel.isHidden = false
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
        cell.like.setTitle(" " + String((self.comment[indexPath.row]?.commentLikes)!), for: .normal)
        cell.userName.text = self.comment[indexPath.row]?.nickname
        
        if comment[indexPath.row]?.like == true { //이미 좋아요를 눌렀다면
            cell.like.setImage(UIImage(named: "likePressed"), for: .normal)
            cell.like.isSelected = true
        }else{
            cell.like.setImage(UIImage(named: "like"), for: .normal)
            cell.like.isSelected = false
        }
        
        cell.like.tag = (comment[indexPath.row]?.commentId)!
        cell.like.addTarget(self, action: #selector(likeComment(_:)), for: .touchUpInside)
        let urlString = self.comment[indexPath.row]?.profileImage
        if let enc_url = urlString?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
            let url = URL(string: enc_url)
            cell.profileImg.kf.setImage(with: url)
            cell.profileImg.contentMode = .scaleAspectFit
        }
        
       
        return cell
    }
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height:CGFloat = scrollView.frame.size.height
        let contentYOffset:CGFloat = scrollView.contentOffset.y
        let scrollViewHeight:CGFloat = scrollView.contentSize.height
        let distanceFromBottom:CGFloat = scrollViewHeight - contentYOffset
        let userId:Int64 = UserDefaults.standard.value(forKey: "userId") as! Int64
        if distanceFromBottom < height {
            self.pageNum = self.pageNum + 1
            commentDataManager.shared.getGominDetail(self, postId: self.postId, pageNum: self.pageNum , userId: userId)
            print("DEBUG: listCount is \(self.comment.count)")
        }
        
    }
    
    @objc func likeComment(_ sendr:UIButton) {
        let userId:Int64 = UserDefaults.standard.value(forKey: "userId") as! Int64
        print("DEBUG: commentID is \(sendr.tag)")
        sendr.isSelected = !sendr.isSelected
//        var count:Int = 0
//        for i in comments {
//            if i.like.tag == sendr.tag {
//                let countString:String = i.likeCount.text!
//                count = Int(countString)!
//                break
//            }
//        }
        print(sendr.isSelected)
        if sendr.isSelected {
            sendr.setImage(UIImage(named: "likePressed"), for: .normal)
//            let current:String = (sendr.title(for: .normal))!
//            var count:Int = Int(current)!
//            count = count + 1
//            sendr.setTitle(String(count), for: .normal)
        }else{
            sendr.setImage(UIImage(named: "like"), for: .normal)
//            let current:String = (sendr.title(for: .normal))!
//            var count:Int = Int(current)!
//            count = count - 1
//            sendr.setTitle(String(count), for: .normal)
        }
        commentLikeDataManager.shared.likeComment(commentVC: self, commentID: sendr.tag, userId: userId , postId: self.postId)
        
        
        
    }
    
    
}
