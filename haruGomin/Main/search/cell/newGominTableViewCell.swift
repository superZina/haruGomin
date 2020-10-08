//
//  newGominTableViewCell.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/26.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class newGominTableViewCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var gominTitle: UILabel!
    @IBOutlet weak var gominContent: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var accuseBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        gominContent.textColor = ColorPalette.textGray
        innerView.backgroundColor = ColorPalette.background
        innerView.layer.cornerRadius = 16
        self.contentView.backgroundColor = ColorPalette.darkBackground
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
