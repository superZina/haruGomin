//
//  searchViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/22.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import Kingfisher

class searchViewController: UIViewController, UICollectionViewDataSource {
    @IBOutlet weak var searchGominBar: UISearchBar!
    @IBOutlet weak var gominCategoryCollection: UICollectionView!
    @IBOutlet weak var gominStoryCollection: UICollectionView!
    @IBOutlet weak var newGominTable: UITableView!
    @IBOutlet weak var searchGomin: UISearchBar!
    @IBOutlet weak var searchbarAndRight: NSLayoutConstraint!
    @IBOutlet weak var text1: UILabel!
    var pageNum:Int = 0
    var tagName:String = "전체"
    var btnText:[tagList] = []
    var btns:[UIButton] = []
    var newGomins:[addedGomin] = []
    var storys:[addedGomin] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        searchGominBar.backgroundColor = ColorPalette.darkBackground

        self.view.backgroundColor = ColorPalette.darkBackground
        self.gominCategoryCollection.backgroundColor = ColorPalette.darkBackground
        self.gominCategoryCollection.backgroundColor = ColorPalette.darkBackground
        self.gominStoryCollection.backgroundColor = ColorPalette.background
        self.newGominTable.backgroundColor = ColorPalette.darkBackground
        
        let itemCellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.gominCategoryCollection.register(itemCellNib, forCellWithReuseIdentifier: "gomin")
        self.gominCategoryCollection.delegate = self
        self.gominCategoryCollection.dataSource = self
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        gominCategoryCollection.collectionViewLayout = layout
        
        let storyCellNib = UINib(nibName: "storyCollectionViewCell", bundle: nil)
        self.gominStoryCollection.register(storyCellNib, forCellWithReuseIdentifier: "story")
        self.gominStoryCollection.delegate = self
        self.gominStoryCollection.dataSource = self
        let storyLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        storyLayout.scrollDirection = .horizontal
        gominStoryCollection.collectionViewLayout = storyLayout
        
        let newGominCellNib = UINib(nibName: "newGominTableViewCell", bundle: nil)
        self.newGominTable.register(newGominCellNib, forCellReuseIdentifier: "newGomin")
        self.newGominTable.delegate = self
        self.newGominTable.dataSource = self
        
        self.searchGominBar.delegate = self
        self.searchGominBar.barTintColor = ColorPalette.darkBackground
        self.searchGominBar.tintColor = ColorPalette.textGray
        let textFieldInsideSearchBar = searchGominBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = ColorPalette.textGray
        self.text1.font = UIFont(name: "NotoSansCJKkr-Medium", size: 20)
        self.searchGominBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        storyDataManager.shared.getStoryList(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.pageNum = 0
        self.tagName = "전체"
        self.navigationController?.isNavigationBarHidden = true
        tagListDataManager.shared.getTagList(self)
        self.newGomins = []
        self.storys = []
        selectTagDatatManager.shared.getTagGomins(self, tagName: tagName, pageNum: 0)
        storyDataManager.shared.getStoryList(self)
    }
    func setTagList(){
        self.gominCategoryCollection.reloadData()
    }
    func setStorys(){
        self.gominStoryCollection.reloadData()
    }
    func refreshGominTable(){
        self.newGominTable.reloadData()
    }

}
extension searchViewController:UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        self.searchbarAndRight.constant = -60
        self.searchGominBar.showsCancelButton = true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let resultVC = searchResultViewController()
        if searchBar.text! != ""{
        resultVC.keyword = searchBar.text!
        self.navigationController?.pushViewController(resultVC, animated: true)
        }else {
            let alert = UIAlertController(title: "잠시만요!", message: "검색어를 입력해주세요! ", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.searchGominBar.text = ""
        self.searchGominBar.showsCancelButton = false
    }
}


extension searchViewController: UICollectionViewDelegateFlowLayout , UITableViewDelegate,UITableViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == gominCategoryCollection {
            return self.btnText.count
        }else {
            return self.storys.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //MARK: 태그 CELL
        if collectionView == gominCategoryCollection{
            let cell = gominCategoryCollection.dequeueReusableCell(withReuseIdentifier: "gomin", for: indexPath) as! CollectionViewCell
            if indexPath.row == 0 {
                gominCategoryCollection.layoutMargins.left = 20
            }
            cell.contentView.backgroundColor = .none
            cell.btn.layer.cornerRadius = 8
            cell.btn.layer.borderWidth = 1
            cell.btn.layer.borderColor = ColorPalette.borderGray.cgColor
            cell.btn.setTitle(btnText[indexPath.item].tagName, for: .normal)
            cell.btn.setTitleColor(ColorPalette.textGray, for: .normal)
            self.btns.append(cell.btn)
            cell.btn.tag = indexPath.item
            cell.btn.addTarget(self, action: #selector(isSelected(_:)), for: .touchUpInside)
            return cell
        }else {
            //MARK: 스토리 Cell
            let storyCell = gominStoryCollection.dequeueReusableCell(withReuseIdentifier: "story", for: indexPath) as! storyCollectionViewCell
            
            // MARK: TIME SETTING
            var createdAt:String = self.storys[indexPath.row].createdDate!
            createdAt = createdAt.replacingOccurrences(of: "T", with: " ") //date String 형식 맞춰주기
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = Date()
            let currnetTimeStr = formatter.string(from: date) //현재시간 String
                    
            let dates = formatter.date(from: createdAt) // 작성시간 date
            let currentDate = formatter.date(from: currnetTimeStr) //현재시간 date
            //differTime이 0이면 게시물 삭제
            let differTime = dates?.timeIntervalSince(currentDate!)
            let restTime = (60 * 60 * 24) + differTime!
            let differHour = Int(restTime / (60 * 60)) //남은 시간
            let differMinute = Int((Int(restTime) - differHour * ( 60 * 60)) / 60 ) //남은 분

            storyCell.time.text = String(differHour) + ":" + String(differMinute) //남은시간
            
            // MARK: IMG SETTING
            let urlString = self.storys[indexPath.row].userProfileImage
            if let enc_url = urlString?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
                let url = URL(string: enc_url)
                storyCell.profileImg.kf.setImage(with: url)
                storyCell.profileImg.contentMode = .scaleAspectFill
                storyCell.profileImg.layer.cornerRadius = 12
            }
            return storyCell
        }
    }
    @objc func isSelected(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.layer.borderColor = ColorPalette.hagoRed.cgColor
            sender.setTitleColor(ColorPalette.hagoRed, for: .normal)
            
            for i in btns {
                if i != sender && i.isSelected {
                    i.isSelected = !i.isSelected
                    i.layer.borderColor = ColorPalette.borderGray.cgColor
                    i.setTitleColor(ColorPalette.textGray, for: .normal)
                }
            }
            self.pageNum = 0
            self.tagName =  sender.title(for: .normal)!
            self.newGomins = [] 
            selectTagDatatManager.shared.getTagGomins(self, tagName: self.tagName, pageNum: self.pageNum)
        }else {
            sender.layer.borderColor = ColorPalette.borderGray.cgColor
            sender.setTitleColor(ColorPalette.textGray, for: .normal)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let postId = self.storys[indexPath.row].postId
        let detailVC = detailGominViewController()
        detailVC.postId = postId!
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == gominStoryCollection {
            return CGSize(width: 72, height: 110)
        }else {
            let size = (btnText[indexPath.item].tagName as! NSString).size(withAttributes: nil).width
            return CGSize(width: size + 40, height: 40)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == gominStoryCollection {
            return UIEdgeInsets(top: 15, left: 20, bottom: 10, right: -8)
        }else{
            return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: -10)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newGomins.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newGominTable.dequeueReusableCell(withIdentifier: "newGomin", for: indexPath) as! newGominTableViewCell
        cell.gominTitle.text = self.newGomins[indexPath.row].title
        cell.gominContent.text = self.newGomins[indexPath.row].content
        let createdAt:String = self.newGomins[indexPath.row].createdDate!
        let createTime:String = createdAt.components(separatedBy: "T")[1]
        let time:[String] = createTime.components(separatedBy: ":")
        cell.time.text = time[0] + ":" + time[1]
        cell.comment.text = String(self.newGomins[indexPath.row].commentNum!)
        cell.accuseBtn.addTarget(self,action: #selector(accuseGomin(_:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postId = self.newGomins[indexPath.row].postId
        let detailVC = detailGominViewController()
        detailVC.postId = postId!
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    @objc func accuseGomin(_ sender: UIButton) {
        let alert = UIAlertController(title: "       ", message: "신중히 생각하셨나요?", preferredStyle: .actionSheet)
        let accuseAction = UIAlertAction(title: "신고하기", style: .destructive) { (action) in
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
        }
        let icon:UIImageView = UIImageView(frame: CGRect(x: alert.view.bounds.width/2 - 18, y: 8, width: 24, height: 24))
        icon.image = UIImage(named: "siren")
        alert.addAction(accuseAction)
        alert.addAction(cancelAction)
        alert.view.addSubview(icon)
//        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = ColorPalette.darkBackground
//        alert.view.tintColor = ColorPalette.textGray
        
        self.present(alert, animated: true, completion: nil)
        print("selected")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height:CGFloat = scrollView.frame.size.height
        let contentYOffset:CGFloat = scrollView.contentOffset.y
        let scrollViewHeight:CGFloat = scrollView.contentSize.height
        let distanceFromBottom:CGFloat = scrollViewHeight - contentYOffset
        
        if distanceFromBottom < height {
            self.pageNum = self.pageNum + 1
            selectTagDatatManager.shared.getTagGomins(self, tagName: self.tagName, pageNum: self.pageNum)
            print("DEBUG: listCount is \(self.newGomins.count)")
        }
        
    }
//
    
}
