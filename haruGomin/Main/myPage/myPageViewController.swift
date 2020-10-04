//
//  myPageViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/22.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class myPageViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var line2: UILabel!
    @IBOutlet weak var myPageTable: UITableView!
    @IBOutlet weak var writingCollectionView: UICollectionView!
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
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = writingCollectionView.dequeueReusableCell(withReuseIdentifier: "myGomin", for: indexPath) as! myWritingCollectionViewCell
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 153)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom:  0, right: 0)
        
    }
}
