//
//  MobileImageCollectionCell.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 7/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import UIKit

class MobileImageCollectionCell: UICollectionViewCell {
    
    static let nibName:String = String(describing: MobileImageCollectionCell.self)
    static let reuseIdentifier:String = String(describing: MobileImageCollectionCell.self)
    
    @IBOutlet weak var imageView: UIImageView!
}

