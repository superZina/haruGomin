//
//  selectGominViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/19.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class selectGominViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var gominCollection: UICollectionView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    var btnText:[String] = ["일상","가족","친구","연애","학교","직장","취업","진로","돈","건강","기혼","육아"]
    var buttons:[UIButton] = []
    override func viewDidLoad() {
        self.view.backgroundColor = ColorPalette.background
        self.infoView.backgroundColor = ColorPalette.borderGray
        self.gominCollection.backgroundColor = ColorPalette.background
        super.viewDidLoad()
        
        
        let itemCellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.gominCollection.register(itemCellNib, forCellWithReuseIdentifier: "gomin")
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        gominCollection.collectionViewLayout = layout
        self.gominCollection.delegate = self
        self.gominCollection.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        nextBtn.layer.cornerRadius = 8
        nextBtn.isEnabled = false
        nextBtn.backgroundColor = ColorPalette.borderGray
    }
    @IBAction func selectAllgomin(_ sender: Any) {
        
    }
    @IBAction func moveNext(_ sender: Any) {
        let mainVC = tabBarViewController()
        self.navigationController?.pushViewController(mainVC,animated: true)
    }
    
    
    
}
extension selectGominViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.btnText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gominCollection.dequeueReusableCell(withReuseIdentifier: "gomin", for: indexPath) as! CollectionViewCell
        cell.contentView.backgroundColor = .none
        cell.btn.layer.cornerRadius = 8
        cell.btn.layer.borderWidth = 1
        cell.btn.layer.borderColor = ColorPalette.borderGray.cgColor
        cell.btn.setTitle(btnText[indexPath.item], for: .normal)
        cell.btn.setTitleColor(ColorPalette.textGray, for: .normal)
        
        cell.btn.addTarget(self, action: #selector(selected(sender:)), for: .touchUpInside)
        return cell
    }
    @objc func selected(sender: UIButton){
        sender.isSelected = !sender.isSelected
        sender.adjustsImageWhenHighlighted = false;
        if sender.isSelected {
            sender.layer.borderColor = ColorPalette.hagoRed.cgColor
            sender.setTitleColor(ColorPalette.hagoRed, for: .normal)
            buttons.append(sender)
        }else {
            sender.layer.borderColor = ColorPalette.borderGray.cgColor
            sender.setTitleColor(ColorPalette.textGray, for: .normal)
            for i in 0...buttons.count - 1 {
                if buttons[i] == sender {
                    buttons.remove(at: i)
                    break
                }
            }
        }
        if buttons.count != 0 {
            self.nextBtn.isEnabled = true
            self.nextBtn.backgroundColor = ColorPalette.hagoRed
        }else {
            self.nextBtn.isEnabled = false
            self.nextBtn.backgroundColor = ColorPalette.borderGray
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 72, height: 40)
    }
    
    
}
