//
//  homeViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/21.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class homeViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var gominCollection: UICollectionView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var gominPageControll: UIPageControl!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var text1: UILabel!
    var gomins:[gomin] = []
    override func viewDidLoad() {
        guard let username:String = UserDefaults.standard.value(forKey: "userName") as? String else {return}
        self.userName.text = username
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = ColorPalette.background
        self.upperView.backgroundColor = ColorPalette.background
        self.gominCollection.backgroundColor = ColorPalette.darkBackground
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.gominCollection.collectionViewLayout = layout
        self.gominCollection.delegate = self
        self.gominCollection.dataSource = self
        let itemCellNib = UINib(nibName: "gominCollectionViewCell", bundle: nil)
        self.gominCollection.register(itemCellNib, forCellWithReuseIdentifier: "gominView")
        let imgCellNib = UINib(nibName: "gominImgCollectionViewCell", bundle: nil)
        self.gominCollection.register(imgCellNib, forCellWithReuseIdentifier: "gominImgView")
        
        // MARK: font
        self.userName.font = UIFont(name: "NotoSansCJKkr-Bold", size: 24)
        self.text1.font = UIFont(name: "NotoSansCJKkr-Bold", size: 24)
        self.text2.font = UIFont(name: "NotoSansCJKkr-Bold", size: 24)
    }
    func setGomin(){
        self.gominCollection.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        mainGominDataManager.shared.getMainGomin(self)
        self.navigationController?.isNavigationBarHidden = true
        gominPageControll.numberOfPages = 3
        gominPageControll.currentPageIndicatorTintColor = ColorPalette.hagoRed
        gominPageControll.tintColor = ColorPalette.hagoRed
    }
    
}
extension homeViewController:UICollectionViewDelegateFlowLayout,UIScrollViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gomins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.gomins[indexPath.row].postImage != "default.png" {
            
            let cell = gominCollection.dequeueReusableCell(withReuseIdentifier: "gominImgView", for: indexPath) as! gominImgCollectionViewCell
            cell.dailyBtn.setTitle(self.gomins[indexPath.row].tagName, for: .normal)
            cell.gominContent.text = self.gomins[indexPath.row].content
            cell.gominTitle.text = self.gomins[indexPath.row].title
            let createdAt:String = self.gomins[indexPath.row].createdDate!
            let createTime:String = createdAt.components(separatedBy: "T")[1]
            let time:[String] = createTime.components(separatedBy: ":")
            cell.createTime.text = time[0] + ":" + time[1]
            cell.detailBtn.tag = self.gomins[indexPath.row].postId!
            cell.detailBtn.addTarget(self, action: #selector(goDetailVC(sender:)), for: .touchUpInside)
            cell.commentCount.text = String(self.gomins[indexPath.row].commentNum!)
            return cell
        }else{
            let cell = gominCollection.dequeueReusableCell(withReuseIdentifier: "gominView", for: indexPath) as! gominCollectionViewCell
            cell.dailyBtn.setTitle(self.gomins[indexPath.row].tagName, for: .normal)
            cell.gominContent.text = self.gomins[indexPath.row].content
            cell.gominTitle.text = self.gomins[indexPath.row].title
            let createdAt:String = self.gomins[indexPath.row].createdDate!
            let createTime:String = createdAt.components(separatedBy: "T")[1]
            let time:[String] = createTime.components(separatedBy: ":")
            cell.createTime.text = time[0] + ":" + time[1]
            cell.detailBtn.tag = self.gomins[indexPath.row].postId!
            cell.detailBtn.addTarget(self, action: #selector(goDetailVC(sender:)), for: .touchUpInside)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: self.gominCollection.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gominPageControll.currentPage = Int(scrollView.contentOffset.x / 300)
    }
    @objc func goDetailVC(sender:UIButton) {
        let detailVC = detailGominViewController()
        detailVC.postId = sender.tag
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
