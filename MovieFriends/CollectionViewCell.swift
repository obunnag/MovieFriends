//
//  CollectionViewCell.swift
//  MovieFriends
//
//  Created by Opal Bunnag on 4/25/19.
//  Copyright © 2019 pb23656. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = UIColor.white
            
            if self.isSelected {
                self.contentView.backgroundColor = UIColor.gray
            }
        }
    }
}
