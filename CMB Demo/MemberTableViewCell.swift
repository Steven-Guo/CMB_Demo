//
//  MemberTableViewCell.swift
//  CMB Demo
//
//  Created by Minxin Guo on 4/30/17.
//  Copyright © 2017 Minxin Guo. All rights reserved.
//

import UIKit
import SDWebImage

class MemberTableViewCell: UITableViewCell {

    var member: Member! {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set avatar to circular view
        avatarImageView.layer.cornerRadius = 30
        avatarImageView.layer.borderWidth = 2.0
        avatarImageView.layer.borderColor = themeColor.cgColor
        avatarImageView.layer.masksToBounds = true
    }

    func updateUI() {
        let fullName = "\(member.firstName) \(member.lastName)"
        let title = member.title
        let avatarURL = URL(string: member.avatarUrlString)
        
        DispatchQueue.main.async {
            self.nameLabel.text = fullName
            self.titleLabel.text = title
            self.avatarImageView.sd_setImage(with: avatarURL)
        }
    }
}
