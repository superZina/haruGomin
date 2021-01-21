//
//  gominCollectionViewCell.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/21.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class gominCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dailyBtn: UIButton!
    @IBOutlet weak var detailBtn: UIButton!
    
    @IBOutlet weak var gominTitle: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var createTime: UILabel!
    @IBOutlet weak var line: UILabel!
    @IBOutlet weak var gominContent: UILabel!
    @IBOutlet weak var innerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.innerView.backgroundColor = ColorPalette.darkBackground
        self.dailyBtn.layer.cornerRadius = 8
        self.detailBtn.layer.cornerRadius = 8
        
        self.dailyBtn.layer.borderWidth = 1
        self.dailyBtn.layer.borderColor = ColorPalette.hagoRed.cgColor
        
        self.detailBtn.backgroundColor = ColorPalette.hagoRed
        
        self.dailyBtn.setTitleColor(ColorPalette.hagoRed, for: .normal)
        self.detailBtn.setTitleColor(ColorPalette.darkBackground, for: .normal)
        gominContent.textColor = ColorPalette.textGray
        
        // MARK: font
        self.gominTitle.font = UIFont(name: "NotoSansCJKkr-Bold", size: 20)
        self.createTime.font = UIFont(name: "Montserrat-Regular", size: 16)
        self.commentCount.font = UIFont(name: "Montserrat-Regular", size: 16)
        self.gominContent.font = UIFont(name: "NotoSansCJKkr-Regular", size: 16)
        self.dailyBtn.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Regular", size: 16)
        self.detailBtn.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 16)
        
        line.backgroundColor = UIColor(red: 83/255, green: 89/255, blue: 116/255, alpha: 1)
    }

}
