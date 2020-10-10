//
//  CollectionViewCell.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/20.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        btn.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Regular", size: 16)
        // Initialization code
    }

}
