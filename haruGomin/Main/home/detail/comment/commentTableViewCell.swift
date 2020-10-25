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
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var ampm: UILabel!
    var isBest:Bool = false
    var isWriter:Bool = false
    override func prepareForReuse() {
        super.prepareForReuse()
    // 초기화 할 코드 예시
        self.additionLabel.isHidden = true
        
    }

    @IBOutlet weak var accuseBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = ColorPalette.darkBackground
        self.innerView.layer.cornerRadius = 8
        self.innerView.backgroundColor = ColorPalette.background
        self.comment.textColor = .white
        self.time.textColor = ColorPalette.textGray
        self.like.setTitleColor(ColorPalette.textGray, for: .normal)
        additionLabel.layer.cornerRadius = 4
        additionLabel.backgroundColor = UIColor(red: 90/255, green: 219/255, blue: 235/255, alpha: 1)
        additionLabel.setTitleColor(ColorPalette.background, for: .normal)
        self.additionLabel.isHidden = true
        


        self.profileImg.layer.cornerRadius = 8
        self.userName.textColor = .white
        self.ampm.textColor = ColorPalette.textGray
        
        // MARK: font
        self.userName.font = UIFont(name: "NotoSansCJKkr-Regular", size: 14)
        self.additionLabel.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 14)
        self.comment.font = UIFont(name: "NotoSansCJKkr-Regular", size: 15)
        self.ampm.font = UIFont(name: "Montserrat-Regular", size: 14)
        self.time.font = UIFont(name: "Montserrat-Regular", size: 14)
//        self.likeCount.font = UIFont(name: "Montserrat-Regular", size: 14)
        
        
    }

    @IBOutlet weak var comment: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
