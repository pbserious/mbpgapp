//
//  MobileListCellViewModel.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 7/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import Foundation

protocol MobileListCellViewModelProtocol {
    
    var mobileData: MobileData! { get set }
    var name: String { get }
    var description: String { get }
    var price: String { get }
    var rating: String { get }
    var thumbnailUrl: URL? { get }
    var isFavourite: Bool { get }
    var isToggleFavouriteEnable: Bool { get }
    
    init(md: MobileData, isToggleFavouriteEnable: Bool)
    
    func toggleFavourite()
    
}

class MobileListCellViewModel: MobileListCellViewModelProtocol {
    
    var mobileData: MobileData!
    var name: String {
        return mobileData.name
    }
    var description: String {
        return mobileData.description
    }
    var price: String {
        return "Price: $\(mobileData.price)"
    }
    var rating: String {
        return "Rating: \(mobileData.rating)"
    }
    var thumbnailUrl: URL? {
        return mobileData.thumbnailUrl
    }
    
    var isFavourite: Bool {
        return FavouriteHelper.shared.isFavourite(for: mobileData.id)
    }
    
    private var isEnableToggle: Bool
    var isToggleFavouriteEnable: Bool {
        return isEnableToggle
    }
    
    required init(md: MobileData, isToggleFavouriteEnable: Bool) {
        self.mobileData = md
        self.isEnableToggle = isToggleFavouriteEnable
    }
    
    func toggleFavourite() {
        // May be return promise instead if use favourite with api
        if isFavourite {
            FavouriteHelper.shared.unfavouriteMobile(for: mobileData.id)
        } else {
            FavouriteHelper.shared.favouriteMobile(for: mobileData.id)
        }
    }
    
}
