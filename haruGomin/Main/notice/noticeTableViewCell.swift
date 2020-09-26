//
//  noticeTableViewCell.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/27.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class noticeTableViewCell: UITableViewCell {

    @IBOutlet weak var underline: UILabel!
    @IBOutlet weak var noticeComment: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        noticeComment.textColor = .white
        days.textColor = ColorPalette.textGray
        time.textColor = ColorPalette.textGray
        self.contentView.backgroundColor = ColorPalette.background
        self.underline.backgroundColor = UIColor(red: 83/255, green: 89/255, blue: 116/255, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
