//
//  gominImgCollectionViewCell.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/21.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class gominImgCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var dailyBtn: UIButton!
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var line: UILabel!
    @IBOutlet weak var gominContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        img.layer.zPosition = -1
        
        self.innerView.backgroundColor = ColorPalette.darkBackground
        self.dailyBtn.layer.cornerRadius = 8
        self.detailBtn.layer.cornerRadius = 8
        
        self.dailyBtn.layer.borderWidth = 1
        self.dailyBtn.layer.borderColor = ColorPalette.hagoRed.cgColor
        
        self.detailBtn.backgroundColor = ColorPalette.hagoRed
        
        self.dailyBtn.setTitleColor(ColorPalette.hagoRed, for: .normal)
        self.detailBtn.setTitleColor(ColorPalette.darkBackground, for: .normal)
        gominContent.textColor = ColorPalette.textGray
        line.backgroundColor = UIColor(red: 83/255, green: 89/255, blue: 116/255, alpha: 1)
    }

}
