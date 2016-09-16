//
//  PeopleTableViewCell.swift
//  CommonWord
//
//  Created by IBM on 9/16/16.
//  Copyright © 2016 eGym. All rights reserved.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {

    @IBOutlet weak var speechDate:UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func layoutSubviews() {
        self.frame = CGRectMake(self.frame.origin.x+5,
                                self.frame.origin.y+10,
                                self.bounds.size.width-10,
                                self.bounds.size.height-5)
        super.layoutSubviews()
    }

}
