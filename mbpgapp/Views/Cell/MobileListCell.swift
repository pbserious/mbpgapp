//
//  MobileListCell.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 6/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import UIKit
import Kingfisher

class MobileListCell: UITableViewCell {
    
    static let nibName: String = String(describing: MobileListCell.self)
    static let reuseIdentifier: String = String(describing: MobileListCell.self)
    
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var priceLabel: UILabel!
    @IBOutlet fileprivate weak var ratingLabel: UILabel!
    @IBOutlet fileprivate weak var favouriteButton: UIButton!
    @IBOutlet fileprivate weak var thumbImageView: UIImageView!
    
    private var vm: MobileListCellViewModelProtocol!
    
    @IBAction func favouritePressed() {
        vm.toggleFavourite()
        updateFavouriteButton()
    }
    
    func setViewModel(_ mp: MobileListCellViewModelProtocol) {
        self.vm = mp
        
        nameLabel.text = vm.name
        descriptionLabel.text = vm.description
        priceLabel.text = vm.price
        ratingLabel.text = vm.rating
        thumbImageView.kf.setImage(with: vm.thumbnailUrl, placeholder: #imageLiteral(resourceName: "ph_default"))
        updateFavouriteButton()
    }
    
    func updateFavouriteButton() {
        let favStateImage =  vm.isFavourite ? #imageLiteral(resourceName: " ic_fav") : #imageLiteral(resourceName: "ic_unfav")
        favouriteButton.setImage(favStateImage, for: .normal)
        favouriteButton.isHidden = !vm.isToggleFavouriteEnable
    }
}
