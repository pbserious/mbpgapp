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
    var favHelper: FavouriteHelperProtocol! { get set }
    var name: String { get }
    var description: String { get }
    var price: String { get }
    var rating: String { get }
    var thumbnailUrl: URL? { get }
    var isFavourite: Bool { get }
    var isToggleFavouriteEnable: Bool { get }
    
    init(md: MobileData,
         fp: FavouriteHelperProtocol,
         isToggleFavouriteEnable: Bool)
    
    func toggleFavourite()
    
}

class MobileListCellViewModel: MobileListCellViewModelProtocol {
    
    var mobileData: MobileData!
    var favHelper: FavouriteHelperProtocol!
    var name: String {
        return mobileData.name
    }
    var description: String {
        return mobileData.description
    }
    var price: String {
        return mobileData.priceFriendlyText
    }
    var rating: String {
        return mobileData.ratingFriendlyText
    }
    var thumbnailUrl: URL? {
        return mobileData.thumbnailUrl
    }
    
    var isFavourite: Bool {
        return favHelper.isFavourite(for: mobileData.id)
    }
    
    private var isEnableToggle: Bool
    var isToggleFavouriteEnable: Bool {
        return isEnableToggle
    }
    
    required init(md: MobileData,
                  fp: FavouriteHelperProtocol,
                  isToggleFavouriteEnable: Bool) {
        self.mobileData = md
        self.favHelper = fp
        self.isEnableToggle = isToggleFavouriteEnable
    }
    
    func toggleFavourite() {
        // May be return promise instead if use favourite with api
        if isFavourite {
            favHelper.unfavouriteMobile(for: mobileData.id)
        } else {
            favHelper.favouriteMobile(for: mobileData.id)
        }
    }
    
}
