//
//  commentTableViewCell.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/21.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class commentTableViewCell: UITableViewCell {

    @IBOutlet weak var additionLabel: UIButton!
    @IBOutlet weak var labelHeight: NSLayoutConstraint!
    @IBOutlet weak var labelAndComment: NSLayoutConstraint!
    @IBOutlet weak var likeNum: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var like: UIButton!
    var isBest:Bool = false
    var isWriter:Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = ColorPalette.darkBackground
        self.innerView.layer.cornerRadius = 8
        self.innerView.backgroundColor = ColorPalette.background
        self.comment.textColor = .white
        self.time.textColor = ColorPalette.textGray
        self.likeNum.textColor = ColorPalette.textGray
        additionLabel.layer.cornerRadius = 4
        additionLabel.backgroundColor = UIColor(red: 90/255, green: 219/255, blue: 235/255, alpha: 1)
        additionLabel.setTitleColor(ColorPalette.background, for: .normal)
        if isBest {
            labelHeight.constant = 0
            labelAndComment.constant = 0
        }
        if isWriter {
            additionLabel.isHidden = true
            let label = UILabel(frame: CGRect(x: 12, y: 10, width: 64, height: 24))
            label.textColor = ColorPalette.hagoRed
            label.text = "* 글쓴이"
            label.font = .boldSystemFont(ofSize: 14)
            innerView.addSubview(label)
        }
        
    }

    @IBOutlet weak var comment: UILabel!
    
    @IBAction func isLiked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setImage(UIImage(named: "likePressed"), for: .normal)
        }else{
            sender.setImage(UIImage(named: "like"), for: .normal)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
