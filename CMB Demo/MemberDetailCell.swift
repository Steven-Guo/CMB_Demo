//
//  MemberDetailCell.swift
//  CMB Demo
//
//  Created by Minxin Guo on 4/30/17.
//  Copyright © 2017 Minxin Guo. All rights reserved.
//

import UIKit

class MemberDetailCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bioTextArea: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
