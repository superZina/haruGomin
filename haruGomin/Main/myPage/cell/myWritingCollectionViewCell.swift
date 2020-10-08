//
//  myWritingCollectionViewCell.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/04.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class myWritingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var content: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var gominTitle: UILabel!
    @IBOutlet weak var gominContent: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var accuseBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.content.backgroundColor = ColorPalette.darkBackground
        self.innerView.backgroundColor = ColorPalette.background
        self.innerView.layer.cornerRadius = 16
        self.gominContent.textColor = ColorPalette.textGray
        
    }

}
