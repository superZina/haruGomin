//
//  profileImgCollectionViewCell.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/04.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class profileImgCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var selectBtn: UIButton!
    override func awakeFromNib() {
        self.contentView.backgroundColor = ColorPalette.darkBackground
        self.img.layer.cornerRadius = 24
        super.awakeFromNib()
    }

}
