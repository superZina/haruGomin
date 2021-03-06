//
//  deleteTableViewCell.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/30.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class deleteTableViewCell: UITableViewCell {

    @IBOutlet weak var menuText: UILabel!
    @IBOutlet weak var additionText: UILabel!
    @IBOutlet weak var seperator: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = ColorPalette.darkBackground
        self.seperator.backgroundColor = ColorPalette.background
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
