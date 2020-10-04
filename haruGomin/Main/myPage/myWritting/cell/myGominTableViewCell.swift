//
//  myGominTableViewCell.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/04.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class myGominTableViewCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var gominTitle: UILabel!
    @IBOutlet weak var gominContent: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = ColorPalette.darkBackground
        self.innerView.backgroundColor = ColorPalette.background
        self.gominContent.textColor = ColorPalette.textGray
        self.innerView.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
