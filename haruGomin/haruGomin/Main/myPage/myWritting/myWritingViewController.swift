//
//  myWritingViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/04.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class myWritingViewController: UIViewController {
    
    
    @IBOutlet weak var myGominTable: UITableView!
    var cells:[myGominTableViewCell] = []
    var selected:[UIButton] = []
    var writings:[addedGomin] = []
    var dates:[String] = []
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var deleteBtn2: UIButton!
    @IBOutlet weak var deleteView: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = ColorPalette.background
        let myGominCellNib = UINib(nibName: "myGominTableViewCell", bundle: nil)
        self.myGominTable.register(myGominCellNib, forCellReuseIdentifier: "mygomin")
        self.myGominTable.delegate = self
        self.myGominTable.dataSource = self
        self.myGominTable.backgroundColor = ColorPalette.darkBackground
        self.view.backgroundColor = ColorPalette.darkBackground
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = ColorPalette.darkBackground
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.topItem?.title = "내 글 보관함"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white ]
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem =  UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(editGomins(_:)))
    }
    override func viewWillAppear(_ animated: Bool) {
        let userId:Int64 = UserDefaults.standard.value(forKey: "userId") as! Int64
        myGominDataManager.shared.getmyGomins(myWritngVC: self, userId: userId, pageNum: 0)
        self.deleteView.isHidden = true
        self.deleteView.backgroundColor = ColorPalette.background
    }
    func reloadgomins() {
        self.myGominTable.reloadData()
    }
    
    @objc func editGomins(_ sender: UIBarButtonItem) {
        if sender.title == "선택" {
            sender.title = "취소"
            self.myGominTable.isUserInteractionEnabled = true
            self.deleteView.isHidden = false
        }else{
            sender.title = "선택"
            self.myGominTable.isUserInteractionEnabled = false
            self.deleteView.isHidden = true
        }
    }
    @IBAction func deleteGomin(_ sender: UIButton) { //삭제
        for i in cells {
            if i.selectBtn.isSelected { //선택되어있다면
                //삭제 api 보내고
                // cells 초기화
                // 내글보관함 부르는 api 다시 호출해서 tableView reload
                i.selectBtn.isSelected = !i.selectBtn.isSelected
                i.innerView.layer.borderWidth = 0
                i.selectBtn.setImage(UIImage(named: "normal"), for: .normal)
            }
        }
    }
}
extension myWritingViewController:UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.writings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = myGominTable.dequeueReusableCell(withIdentifier: "mygomin") as? myGominTableViewCell else {
            return UITableViewCell()
        }
        cell.gominTitle.text = self.writings[indexPath.row].title
        cell.gominContent.text = self.writings[indexPath.row].content
        cell.selectBtn.isHidden = true
//        cell.postId = writings[indexPath.row].postId!
//        self.cells.append(cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! myGominTableViewCell
//        var idx:Int = 0
//        for i in 0...self.writings.count-1 {
//            if cell.postId == writings[i].postId {
//                idx = i
//            }
//        }
//        print("idx is : \(idx)")
        cell.selectBtn.isSelected = !cell.selectBtn.isSelected
        if cell.selectBtn.isSelected {
            cell.innerView.layer.borderColor = ColorPalette.hagoRed.cgColor
            cell.innerView.layer.borderWidth = 1
            cell.selectBtn.setImage(UIImage(named: "pressed"), for: .normal)
        }else{
            cell.innerView.layer.borderWidth = 0
            cell.selectBtn.setImage(UIImage(named: "normal"), for: .normal)
        }
    }
}
