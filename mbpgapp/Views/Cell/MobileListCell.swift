//
//  MobileListCell.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 6/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import UIKit
import Kingfisher

typealias ActionHandler<T> = (T) -> Void

class MobileListCell: UITableViewCell {
    
    static let nibName: String = String(describing: MobileListCell.self)
    static let reuseIdentifier: String = String(describing: MobileListCell.self)
    
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var priceLabel: UILabel!
    @IBOutlet fileprivate weak var ratingLabel: UILabel!
    @IBOutlet fileprivate weak var favouriteButton: UIButton!
    @IBOutlet fileprivate weak var thumbImageView: UIImageView!
    
    var favouriteActionHandler: ActionHandler<UIButton> = { btn in
        print("favouriteActionHandler is not implemented")
    }
    
    @IBAction func favouritePressed() {
        
    }
    
    func setData(_ mobileData: MobileData) {
        nameLabel.text = mobileData.name
        descriptionLabel.text = mobileData.description
        priceLabel.text = "Price: $\(mobileData.price)"
        ratingLabel.text = "Rating: \(mobileData.rating)"
        thumbImageView.kf.setImage(with: mobileData.thumbnailUrl, placeholder: nil)
    }
    
}
