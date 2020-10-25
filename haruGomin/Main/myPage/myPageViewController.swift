//
//  myPageViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/22.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import NaverThirdPartyLogin
import Kingfisher

class myPageViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var line2: UILabel!
    @IBOutlet weak var myPageTable: UITableView!
    @IBOutlet weak var writingCollectionView: UICollectionView!
    @IBOutlet weak var loginTypeImg: UIImageView!
    @IBOutlet weak var haruGomin: UILabel!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var myGominCollectionHeight: NSLayoutConstraint!
    
    var myPosting:[addedGomin] = []
    var pageNum:Int = 0
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let imageNum:String = UserDefaults.standard.value( forKey: "profileImage") as! String
        let loginType:String = UserDefaults.standard.value( forKey:  "loginType") as! String
        
        self.loginTypeImg.image = UIImage(named: loginType)
        self.profileImg.layer.cornerRadius = 16
        self.profileImg.image = UIImage(named: imageNum)
        
        self.view.backgroundColor = ColorPalette.darkBackground
        self.line1.backgroundColor = ColorPalette.background
        self.line2.backgroundColor = ColorPalette.background
        self.haruGomin.textColor = ColorPalette.textGray
        
        // MARK: font
        self.nickName.font = UIFont.textStyle2
        self.haruGomin.font = UIFont.textStyle3
        self.text1.font = UIFont(name: "NotoSansCJKkr-Bold", size: 16)
        self.editBtn.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Regular", size: 12)
        
        let menuCellNib = UINib(nibName: "myWrittenTableViewCell", bundle: nil)
        self.myPageTable.register(menuCellNib, forCellReuseIdentifier: "menuCell")
        let deleteCellNib = UINib(nibName: "deleteTableViewCell", bundle: nil)
        self.myPageTable.register(deleteCellNib, forCellReuseIdentifier: "deleteCell")
        self.myPageTable.delegate = self
        self.myPageTable.dataSource = self
        self.myPageTable.backgroundColor = ColorPalette.darkBackground
        
        let mygominNib = UINib(nibName: "myWritingCollectionViewCell", bundle: nil)
        self.writingCollectionView.register(mygominNib, forCellWithReuseIdentifier: "myGomin")
        let defaultCellNib = UINib(nibName: "defaultCollectionViewCell", bundle: nil)
        self.writingCollectionView.register(defaultCellNib, forCellWithReuseIdentifier: "default")
        self.writingCollectionView.delegate = self
        self.writingCollectionView.dataSource = self
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        writingCollectionView.collectionViewLayout = layout
        self.writingCollectionView.backgroundColor = ColorPalette.darkBackground
        
        
        let userName : String = UserDefaults
            .standard.value(forKey: "userName") as! String
        self.nickName.text = userName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userId:Int64 = UserDefaults.standard.value(forKey: "userId") as! Int64
        print("UserID:\(userId)")
        let jwt:String = UserDefaults.standard.value(forKey: "jwt") as! String
        print("DEBUG: jwt is \(jwt)")
        let urlString:String = UserDefaults.standard.value(forKey: "profileImage") as! String
        if let enc_url = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
            let url = URL(string: enc_url)
            self.profileImg.kf.setImage(with: url)
        }
        myPostingDataManager.shared.getmyPostings(myPageVC: self, userId: userId, pageNum: pageNum)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setmyPosting(){
        self.writingCollectionView.reloadData()
    }
    @IBAction func editProfile(_ sender: Any) {
        let editProfileVC = editProfileViewController()
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    
}
extension myPageViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = myPageTable.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? myWrittenTableViewCell else {return UITableViewCell()}
            cell.alarmVal.isHidden = true
            return cell
            
//        }else if indexPath.row == 1 {
//            guard let cell = myPageTable.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? myWrittenTableViewCell else {return UITableViewCell()}
//            cell.alarmVal.isHidden = false
//            cell.alarmVal.textColor = ColorPalette.background
//            cell.icon.setImage(UIImage(named: "whiteCopy"), for: .normal)
//            cell.menuText.text = "푸시 알림"
//            return cell
        }else if indexPath.row == 2 {
            guard let cell = myPageTable.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? myWrittenTableViewCell else {return UITableViewCell()}
            cell.icon.setImage(UIImage(named: "logout"), for: .normal)
            cell.menuText.text = "로그아웃"
            cell.alarmVal.isHidden = true
            return cell
        }else{
            guard let cell = myPageTable.dequeueReusableCell(withIdentifier: "deleteCell", for: indexPath) as? deleteTableViewCell else {return UITableViewCell()}
            cell.menuText.font = UIFont(name: "NotoSansCJKkr-Regular", size: 16)
            cell.additionText.textColor = ColorPalette.textGray
            cell.additionText.font = UIFont(name: "NotoSansCJKkr-Regular", size: 14)
            cell.menuText.textColor = UIColor(red: 255/255, green: 77/255, blue: 77/255, alpha: 1)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let myWriting = myWritingViewController()
            self.navigationController?.pushViewController(myWriting, animated: true)
        }else if indexPath.row == 1 {
            let alert = UIAlertController(title: "계정탈퇴", message: nil, preferredStyle: .actionSheet)
            let logOutAction = UIAlertAction(title: "계정탈퇴하기", style: .default) { (action) in
                let loginType:String = UserDefaults.standard.value(forKey: "loginType") as! String
                if loginType == "kakao" {
                    UserApi.shared.unlink {(error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            UserDefaults.standard.setValue(false, forKey: "isLogin")
                            
                            print("unlink success")
                            let userId:Int64 = UserDefaults.standard.value(forKey: "userId") as! Int64
                            deleteUserDataManager.shared.deleteUser(self, userId: userId)
                            
                        }
                    }
                }else if loginType == "naver" {
                    UserDefaults.standard.setValue(false, forKey: "isLogin")
                    NaverThirdPartyLoginConnection.getSharedInstance()?.requestDeleteToken()
                    let userId:Int64 = UserDefaults.standard.value(forKey: "userId") as! Int64
                    deleteUserDataManager.shared.deleteUser(self, userId: userId)
                }else if loginType == "apple" {
                    let loginVC = logInViewController()
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = UINavigationController(rootViewController:loginVC)
                        UIView.transition(with: window, duration: 0.5, options: .beginFromCurrentState, animations: {}, completion: nil)
                    } else {
                        loginVC.modalPresentationStyle = .overFullScreen
                        self
                            .present(loginVC, animated: true, completion: nil)
                    }
                    
                }
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(logOutAction)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }else if indexPath.row == 2 {
            let alert = UIAlertController(title: "로그아웃", message: nil, preferredStyle: .actionSheet)
            let logOutAction = UIAlertAction(title: "로그아웃하기", style: .default) { (action) in
                let loginType:String = UserDefaults.standard.value(forKey: "loginType") as! String
                if loginType == "kakao" {
                    UserApi.shared.logout {(error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            UserDefaults.standard.setValue(false, forKey: "isLogin")
                            let loginVC = logInViewController()
                            if let window = UIApplication.shared.windows.first {
                                window.rootViewController = UINavigationController(rootViewController:loginVC)
                                UIView.transition(with: window, duration: 0.5, options: .beginFromCurrentState, animations: {}, completion: nil)
                            } else {
                                loginVC.modalPresentationStyle = .overFullScreen
                                self
                                    .present(loginVC, animated: true, completion: nil)
                            }
                        }
                    }
                }else if loginType == "naver" {
                    UserDefaults.standard.setValue(false, forKey: "isLogin")
                    NaverThirdPartyLoginConnection.getSharedInstance()?.requestDeleteToken()
                    let loginVC = logInViewController()
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = UINavigationController(rootViewController:loginVC)
                        UIView.transition(with: window, duration: 0.5, options: .beginFromCurrentState, animations: {}, completion: nil)
                    } else {
                        loginVC.modalPresentationStyle = .overFullScreen
                        self
                            .present(loginVC, animated: true, completion: nil)
                    }
                }else if loginType == "apple" {
                    let loginVC = logInViewController()
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = UINavigationController(rootViewController:loginVC)
                        UIView.transition(with: window, duration: 0.5, options: .beginFromCurrentState, animations: {}, completion: nil)
                    } else {
                        loginVC.modalPresentationStyle = .overFullScreen
                        self
                            .present(loginVC, animated: true, completion: nil)
                    }
                    
                }
            }
                
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(logOutAction)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }else{
           
        }
    }
    
}


extension myPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.myPosting.count == 0{
            return 1
        }else{
            return self.myPosting.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if myPosting.count != 0 {
            self.writingCollectionView.isScrollEnabled = true
            let cell = writingCollectionView.dequeueReusableCell(withReuseIdentifier: "myGomin", for: indexPath) as! myWritingCollectionViewCell
            cell.gominTitle.text = self.myPosting[indexPath.row].title
            cell.gominContent.text = self.myPosting[indexPath.row].content
            
            cell.commentCount.text = String(self.myPosting[indexPath.row].commentNum!)
            cell.accuseBtn.tag = self.myPosting[indexPath.row].postId!
            cell.accuseBtn.addTarget(self,action: #selector(accuseGomin(_:)), for: .touchUpInside)
            
            // MARK: font
            cell.gominTitle.font = UIFont(name: "NotoSansCJKkr-Bold", size: 16)
            cell.gominContent.font = UIFont(name: "NotoSansCJKkr-Regular", size: 15)
            cell.time.font = UIFont(name: "Montserrat-Regular", size: 16)
            cell.commentCount.font = UIFont(name: "Montserrat-Regular", size: 16)
            
            // MARK: TIME SETTING
            var createdAt:String = self.myPosting[indexPath.row].createdDate!
            let createTime:String = createdAt.components(separatedBy: "T")[1]
            let time:[String] = createTime.components(separatedBy: ":")
            cell.time.text = time[0] + ":" + time[1]
            createdAt = createdAt.replacingOccurrences(of: "T", with: " ") //date String 형식 맞춰주기
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = Date()
            let currnetTimeStr = formatter.string(from: date) //현재시간 String
                    
            let dates = formatter.date(from: createdAt) // 작성시간 date
            let currentDate = formatter.date(from: currnetTimeStr) //현재시간 date
            
          
            
            return cell
        }else{
            let cell = writingCollectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as! defaultCollectionViewCell
            self.writingCollectionView.isScrollEnabled = false
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.myPosting.count != 0 {
            let postId = self.myPosting[indexPath.item].postId
            let detailVC = detailGominViewController()
            detailVC.postId = postId!
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if myPosting.count == 0 {
            self.myGominCollectionHeight.constant = 72
            return CGSize(width: self.view.bounds.width, height: 72)
        }else{
            self.myGominCollectionHeight.constant = 153
            return CGSize(width: self.view.bounds.width, height: 153)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom:  0, right: 0)
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height:CGFloat = scrollView.frame.size.width
        let contentYOffset:CGFloat = scrollView.contentOffset.x
        let scrollViewHeight:CGFloat = scrollView.contentSize.width
        let distanceFromBottom:CGFloat = scrollViewHeight - contentYOffset
        let userId:Int64 = UserDefaults.standard.value(forKey: "userId") as! Int64
        if distanceFromBottom < height {
            self.pageNum = self.pageNum + 1
            myPostingDataManager.shared.getmyPostings(myPageVC: self, userId: userId, pageNum: self.pageNum)
            print("DEBUG: listCount is \(self.myPosting.count)")
        }
        
    }
    
    @objc func accuseGomin(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive) { (action) in
            deleteDataManager.shared.deletePost(self, postId: sender.tag)
        }
//        let editAction = UIAlertAction(title: "수정하기", style: .default) { (action) in
//            let postInfo:addedGomin = self.myPosting[sender.tag]
//
//            let addGominVC = addGominViewController()
//            addGominVC.Title = postInfo.title!
//            addGominVC.Content = postInfo.content!
//            addGominVC.postId = postInfo.postId!
//            addGominVC.modalPresentationStyle = .overFullScreen
//            self.present(addGominVC, animated: true)
//        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
        }
        
        alert.addAction(deleteAction)
//        alert.addAction(editAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        print("selected")
    }
}
