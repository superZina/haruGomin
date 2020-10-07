//
//  searchResultViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/07.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class searchResultViewController: UIViewController {

    var keyword:String = ""
    var results:[addedGomin] = []
    @IBOutlet weak var resultTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorPalette.darkBackground
        self.resultTableView.delegate = self
        self.resultTableView.dataSource = self
        let newGominCellNib = UINib(nibName: "newGominTableViewCell", bundle: nil)
        self.resultTableView.register(newGominCellNib, forCellReuseIdentifier: "newGomin")
        
        self.resultTableView.backgroundColor = ColorPalette.darkBackground
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = ColorPalette.darkBackground
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.topItem?.title = self.keyword
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .always
        }
    override func viewWillAppear(_ animated: Bool) {
        searchDataManager.shared.getSearchResult(self, self.keyword, 0)
    }
}
extension searchResultViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultTableView.dequeueReusableCell(withIdentifier: "newGomin", for: indexPath) as! newGominTableViewCell
        cell.gominTitle.text = self.results[indexPath.row].title
        cell.gominContent.text = self.results[indexPath.row].content
        let createdAt:String = self.results[indexPath.row].createdDate!
        let createTime:String = createdAt.components(separatedBy: "T")[1]
        let time:[String] = createTime.components(separatedBy: ":")
        cell.time.text = time[0] + ":" + time[1]
        return cell
    }
    
    
}
