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
    
    @IBOutlet weak var gominPageControll: UIPageControl!
    @IBOutlet weak var upperView: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = ColorPalette.background
        self.upperView.backgroundColor = ColorPalette.background
        self.gominCollection.backgroundColor = ColorPalette.darkBackground
        self.gominCollection.delegate = self
        self.gominCollection.dataSource = self
        let itemCellNib = UINib(nibName: "gominCollectionViewCell", bundle: nil)
        self.gominCollection.register(itemCellNib, forCellWithReuseIdentifier: "gominView")
        let imgCellNib = UINib(nibName: "gominImgCollectionViewCell", bundle: nil)
        self.gominCollection.register(imgCellNib, forCellWithReuseIdentifier: "gominImgView")
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        gominPageControll.numberOfPages = 3
        gominPageControll.currentPageIndicatorTintColor = ColorPalette.hagoRed
        gominPageControll.tintColor = ColorPalette.hagoRed
    }
    
}
extension homeViewController:UICollectionViewDelegateFlowLayout,UIScrollViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gominCollection.dequeueReusableCell(withReuseIdentifier: "gominImgView", for: indexPath) as! gominImgCollectionViewCell
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: self.gominCollection.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: -10, bottom: 0, right: -10)
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = detailGominViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gominPageControll.currentPage = Int(scrollView.contentOffset.x / 300)
    }
}
