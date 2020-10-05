//
//  searchViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/22.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class searchViewController: UIViewController, UICollectionViewDataSource {
    @IBOutlet weak var searchGominBar: UISearchBar!
    @IBOutlet weak var gominCategoryCollection: UICollectionView!
    @IBOutlet weak var gominStoryCollection: UICollectionView!
    @IBOutlet weak var newGominTable: UITableView!
    var btnText:[tagList] = []
    var btns:[UIButton] = []
    var newGomins:[addedGomin] = []
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    override func viewWillAppear(_ animated: Bool) {
        tagListDataManager.shared.getTagList(self)
    }
    func setTagList(){
        self.gominCategoryCollection.reloadData()
    }
    func refreshGominTable(){
        self.newGominTable.reloadData()
    }

}
extension searchViewController: UICollectionViewDelegateFlowLayout , UITableViewDelegate,UITableViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == gominCategoryCollection {
            return self.btnText.count
        }else {
            return 10
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
            selectTagDatatManager.shared.getTagGomins(self, tagName: sender.title(for: .normal)!, pageNum: 0)
        }else {
            sender.layer.borderColor = ColorPalette.borderGray.cgColor
            sender.setTitleColor(ColorPalette.textGray, for: .normal)
        }
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
        return cell
    }
//
    
}
