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
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = ColorPalette.background
        let myGominCellNib = UINib(nibName: "myGominTableViewCell", bundle: nil)
        self.myGominTable.register(myGominCellNib, forCellReuseIdentifier: "mygomin")
        self.myGominTable.delegate = self
        self.myGominTable.dataSource = self
        self.myGominTable.backgroundColor = ColorPalette.darkBackground
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}
extension myWritingViewController:UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = myGominTable.dequeueReusableCell(withIdentifier: "mygomin") as? myGominTableViewCell else {
            return UITableViewCell()
        }
        self.cells.append(cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cells[indexPath.row].selectBtn.isSelected = !self.cells[indexPath.row].selectBtn.isSelected
        if self.cells[indexPath.row].selectBtn.isSelected {
            self.cells[indexPath.row].innerView.layer.borderColor = ColorPalette.hagoRed.cgColor
            self.cells[indexPath.row].innerView.layer.borderWidth = 1
            self.cells[indexPath.row].selectBtn.setImage(UIImage(named: "pressed"), for: .normal)
        }else{
            self.cells[indexPath.row].innerView.layer.borderWidth = 0
            self.cells[indexPath.row].selectBtn.setImage(UIImage(named: "normal"), for: .normal)
        }
        
    }
}
