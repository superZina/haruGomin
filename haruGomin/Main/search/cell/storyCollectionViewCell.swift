//
//  storyCollectionViewCell.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/26.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class storyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var storyBtn: UIButton!
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.innerView.backgroundColor = ColorPalette.background
        self.storyBtn.layer.cornerRadius = 16
        self.storyBtn.backgroundColor = ColorPalette.hagoRed
        self.time.font = UIFont(name: "Montserrat-Regular", size: 16)
    }

}
