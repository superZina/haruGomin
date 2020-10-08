//
//  myPageViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/22.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class myPageViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var line2: UILabel!
    @IBOutlet weak var myPageTable: UITableView!
    @IBOutlet weak var writingCollectionView: UICollectionView!
    var myPosting:[addedGomin] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorPalette.darkBackground
        self.line1.backgroundColor = ColorPalette.background
        self.line2.backgroundColor = ColorPalette.background
        
        
        let menuCellNib = UINib(nibName: "myWrittenTableViewCell", bundle: nil)
        self.myPageTable.register(menuCellNib, forCellReuseIdentifier: "menuCell")
        let deleteCellNib = UINib(nibName: "deleteTableViewCell", bundle: nil)
        self.myPageTable.register(deleteCellNib, forCellReuseIdentifier: "deleteCell")
        self.myPageTable.delegate = self
        self.myPageTable.dataSource = self
        self.myPageTable.backgroundColor = ColorPalette.darkBackground
        
        let mygominNib = UINib(nibName: "myWritingCollectionViewCell", bundle: nil)
        self.writingCollectionView.register(mygominNib, forCellWithReuseIdentifier: "myGomin")
        self.writingCollectionView.delegate = self
        self.writingCollectionView.dataSource = self
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        writingCollectionView.collectionViewLayout = layout
        self.writingCollectionView.backgroundColor = ColorPalette.darkBackground
        
        
        let userName : String = UserDefaults.standard.value(forKey: "userName") as! String
        self.nickName.text = userName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userId:Int64 = UserDefaults.standard.value(forKey: "userId") as! Int64
        print("UserID:\(userId)")
        let jwt:String = UserDefaults.standard.value(forKey: "jwt") as! String
        print("DEBUG: jwt is \(jwt)")
        myPostingDataManager.shared.getmyPostings(myPageVC: self, userId: userId, pageNum: 0)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setmyPosting(){
        self.writingCollectionView.reloadData()
    }


}
extension myPageViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = myPageTable.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? myWrittenTableViewCell else {return UITableViewCell()}
            cell.alarmVal.isHidden = true
            return cell
            
        }else if indexPath.row == 1 {
            guard let cell = myPageTable.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? myWrittenTableViewCell else {return UITableViewCell()}
            cell.alarmVal.isHidden = false
            cell.alarmVal.textColor = ColorPalette.background
            cell.icon.setImage(UIImage(named: "whiteCopy"), for: .normal)
            cell.menuText.text = "푸시 알림"
            return cell
        }else if indexPath.row == 2 {
            guard let cell = myPageTable.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? myWrittenTableViewCell else {return UITableViewCell()}
            cell.icon.setImage(UIImage(named: "logout"), for: .normal)
            cell.menuText.text = "로그아웃"
            cell.alarmVal.isHidden = true
            return cell
        }else{
            guard let cell = myPageTable.dequeueReusableCell(withIdentifier: "deleteCell", for: indexPath) as? deleteTableViewCell else {return UITableViewCell()}
            cell.additionText.textColor = ColorPalette.textGray
            cell.menuText.textColor = UIColor(red: 255/255, green: 77/255, blue: 77/255, alpha: 1)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let myWriting = myWritingViewController()
            self.navigationController?.pushViewController(myWriting, animated: true)
        }else if indexPath.row == 1 {
            //푸시알림 설정
        }else if indexPath.row == 2 {
            //로그아웃
        }else{
            //계정삭제
            }
        }
        
    }
    

extension myPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myPosting.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = writingCollectionView.dequeueReusableCell(withReuseIdentifier: "myGomin", for: indexPath) as! myWritingCollectionViewCell
        cell.gominTitle.text = self.myPosting[indexPath.row].title
        cell.gominContent.text = self.myPosting[indexPath.row].content
        let createdAt:String = self.myPosting[indexPath.row].createdDate!
        let createTime:String = createdAt.components(separatedBy: "T")[1]
        let time:[String] = createTime.components(separatedBy: ":")
        cell.time.text = time[0] + ":" + time[1]
        cell.accuseBtn.tag = indexPath.row
        cell.accuseBtn.addTarget(self,action: #selector(accuseGomin(_:)), for: .touchUpInside)
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let postId = self.myPosting[indexPath.item].postId
        let detailVC = detailGominViewController()
        detailVC.postId = postId!
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 153)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom:  0, right: 0)
        
    }
    @objc func accuseGomin(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive) { (action) in
            
        }
        let editAction = UIAlertAction(title: "수정하기", style: .default) { (action) in
            let postInfo:addedGomin = self.myPosting[sender.tag]
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
        }
        let icon:UIImageView = UIImageView(frame: CGRect(x: alert.view.bounds.width/2 - 18, y: 8, width: 24, height: 24))
        icon.image = UIImage(named: "siren")
        alert.addAction(deleteAction)
        alert.addAction(editAction)
        alert.addAction(cancelAction)
        alert.view.addSubview(icon)
        self.present(alert, animated: true, completion: nil)
        print("selected")
    }
}
