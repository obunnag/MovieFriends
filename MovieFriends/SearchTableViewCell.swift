//
//  SearchTableViewCell.swift
//  MovieFriends
//
//  Created by Opal Bunnag on 5/6/19.
//  Copyright © 2019 pb23656. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
