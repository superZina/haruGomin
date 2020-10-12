//
//  defaultCollectionViewCell.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/12.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class defaultCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.innerView.backgroundColor = ColorPalette.background
        self.innerView.layer.cornerRadius = 12
        self.text1.textColor = ColorPalette.textGray
        self.text2.textColor = ColorPalette.textGray
        self.text1.font = UIFont(name: "NotoSansCJKkr-Regular", size: 14)
        self.text2.font = UIFont(name: "NotoSansCJKkr-Regular", size: 14)
    }

}
