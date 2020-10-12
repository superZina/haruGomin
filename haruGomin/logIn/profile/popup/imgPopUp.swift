//
//  imgPopUp.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/04.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class imgPopUp: UIViewController, UICollectionViewDataSource{
    var imgPopupDelegate:imgPopUpDelegate!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var imgCollectionView: UICollectionView!
    var selectedImg:Int = 0
    var buttons:[UIButton] = []
    var images:[UIImage] = []
    var imgs:[String] = ["https://hago-storage-bucket.s3.ap-northeast-2.amazonaws.com/default_01.jpg","https://hago-storage-bucket.s3.ap-northeast-2.amazonaws.com/default_02.jpg","https://hago-storage-bucket.s3.ap-northeast-2.amazonaws.com/default_03.jpg","https://hago-storage-bucket.s3.ap-northeast-2.amazonaws.com/default_04.jpg"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popupView.layer.cornerRadius = 16
        self.closeBtn.setTitleColor(ColorPalette.textGray, for: .normal)
        self.doneBtn.setTitleColor(ColorPalette.hagoRed, for: .normal)
        self.popupView.backgroundColor = ColorPalette.darkBackground
        self.imgCollectionView.backgroundColor = ColorPalette.darkBackground
        
        let itemCellNib = UINib(nibName: "profileImgCollectionViewCell", bundle: nil)
        self.imgCollectionView.register(itemCellNib, forCellWithReuseIdentifier: "imgCell")
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.imgCollectionView.collectionViewLayout = layout
        self.imgCollectionView.delegate = self
        self.imgCollectionView.dataSource = self
        
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true) { [self] in
            self.imgPopupDelegate.pressDismissBtn(imgName: self.imgs[selectedImg])
        }
    }
    
}

extension imgPopUp: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imgs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imgCollectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath) as! profileImgCollectionViewCell
        let urlString = imgs[indexPath.item]
        if let enc_url = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
            let url = URL(string: enc_url)
            cell.img.kf.setImage(with: url)
        }
        
        self.buttons.append(cell.selectBtn)
        cell.selectBtn.tag = indexPath.item
        cell.selectBtn.addTarget(self, action: #selector(selectImg(sender:)), for: .touchUpInside)
//        self.images.append(cell.img.image!)
        return cell
    }
    @objc func selectImg(sender: UIButton) {
        //        sender.isSelected = !sender.isSelected
        //        if sender.isSelected {
        //            sender.setImage(UIImage(named: "pressed"), for: .normal)
        //            selectedImg = sender.tag
        //            for i in buttons {
        //                if i != sender && i.isSelected{
        //                    i.isSelected = !i.isSelected
        //                    i.setImage(UIImage(named: "normal"), for: .normal)
        //                }
        //            }
        //        }else{
        //            sender.setImage(UIImage(named: "normal"), for: .normal)
        //        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        buttons[indexPath.item].isSelected = !buttons[indexPath.item].isSelected
        if buttons[indexPath.item].isSelected {
            buttons[indexPath.item].setImage(UIImage(named: "pressed"), for: .normal)
            selectedImg = indexPath.item
            for i in buttons {
                if i != buttons[indexPath.item] && i.isSelected{
                    i.isSelected = !i.isSelected
                    i.setImage(UIImage(named: "normal"), for: .normal)
                }
            }
        }else{
            buttons[indexPath.item].setImage(UIImage(named: "normal"), for: .normal)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: self.imgCollectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -8)
    }
}
