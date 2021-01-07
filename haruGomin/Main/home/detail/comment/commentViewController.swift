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
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentTextView: UIView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
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
        self.commentTextField.delegate = self
        self.commentTextView.backgroundColor = ColorPalette.darkBackground
        self.commentView.layer.cornerRadius = 8
        self.commentView.layer.borderColor = ColorPalette.borderGray.cgColor
        self.commentView.layer.borderWidth = 1
        
        self.commentTextField.textColor = .white
        self.commentTextView.backgroundColor = ColorPalette.darkBackground
        self.commentView.backgroundColor = ColorPalette.darkBackground
        self.commentTextField.isEnabled = true
        self.view.isUserInteractionEnabled = true
        self.commentTextField.attributedPlaceholder = NSAttributedString(string: "   댓글을 입력해 주세요",            attributes: [NSAttributedString.Key.foregroundColor: ColorPalette.borderGray])
//        self.commentTextField.delegate = self
        self.commentTextField.addLeftPadding(imgName: "")
        self.commentTextField.addTarget(self, action: #selector(textfieldChanged(_:)), for: .editingChanged)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.pageNum = 0
        let userId:Int64 = UserDefaults.standard.value(forKey: "userId") as! Int64
        commentDataManager.shared.getGominDetail(self, postId: self.postId, pageNum: self.pageNum , userId: userId)
//        self.view.layoutIfNeeded()
        self.commentBtn.isEnabled  = false
    }
    @IBAction func registComment(_ sender: Any) {
        let userName:String = UserDefaults.standard.value(forKey: "userName") as! String
        let profileImg:String = UserDefaults.standard.value(forKey: "profileImage") as! String
        let userId:Int64 = UserDefaults.standard.value(forKey: "userId") as! Int64
        let parameters:[String:Any] = [
            "content": self.commentTextField.text,
            "nickname": userName,
            "postId": self.postId,
            "profileImage": profileImg,
            "userId": userId
        ]
        registCommentDataManager.shared.registComment(self , parameters: parameters , userId: userId)
        
    }
    @objc func textfieldChanged(_ textfield: UITextField) {
        if(textfield.text != "") {
            self.commentBtn.setImage(UIImage(named: "sendMessagePurple"), for: .normal)
            self.commentBtn.isEnabled  = true
        }else{
            self.commentBtn.setImage(UIImage(named: "sendMessageGray"), for: .normal)
            self.commentBtn.isEnabled  = false
        }
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        if endFrameY >= UIScreen.main.bounds.size.height {
            self.keyboardHeightLayoutConstraint?.constant = 0.0
        } else {
            self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
        }
        
        UIView.animate(
            withDuration: duration,
            delay: TimeInterval(0),
            options: animationCurve,
            animations: { self.view.layoutIfNeeded() },
            completion: nil)
    }
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
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
        cell.accuseBtn.addTarget(self, action: #selector(accuseGomin) , for: .touchUpInside)
        let urlString = self.comment[indexPath.row]?.profileImage
        if let enc_url = urlString?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
            let url = URL(string: enc_url)
            cell.profileImg.kf.setImage(with: url)
            cell.profileImg.contentMode = .scaleAspectFit
        }
        
       
        return cell
    }
    @objc func accuseGomin() {
        let alert = UIAlertController(title: "신고하기", message: "신중히 생각하셨나요?", preferredStyle: .alert)
        let accuseAction = UIAlertAction(title: "신고하기", style: .destructive) { (action) in
            let okAlert = UIAlertController(title: "신고완료", message: "신고가 완료되었어요!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            okAlert.addAction(ok)
            self.present(okAlert, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(accuseAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        print("selected")
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
        print(sendr.isSelected)
        if sendr.isSelected {
            sendr.setImage(UIImage(named: "likePressed"), for: .normal)
        }else{
            sendr.setImage(UIImage(named: "like"), for: .normal)
        }
        commentLikeDataManager.shared.likeComment(commentVC: self, commentID: sendr.tag, userId: userId , postId: self.postId)
    }
}
extension commentViewController:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.text != "") {
            self.commentBtn.setImage(UIImage(named: "sendMessagePurple"), for: .normal)
            self.commentBtn.isEnabled  = true
        }else{
            self.commentBtn.setImage(UIImage(named: "sendMessageGray"), for: .normal)
            self.commentBtn.isEnabled  = false
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if(string == "\n"){
                textField.resignFirstResponder()
            }
           return true
       
        }
   
}
