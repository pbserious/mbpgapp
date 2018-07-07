//
//  MobileDetailViewModel.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 7/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import Foundation

class MobileDetailViewModel {
    
    fileprivate var usecase: MobileInfoUseCaseProtocol!
    fileprivate var mobileData: MobileData!
    fileprivate var imageUrlList = [URL]()
    
    init(uc: MobileInfoUseCaseProtocol, md: MobileData) {
        self.usecase = uc
        self.mobileData = md
    }
    
    var dataChangedHandler: () -> Void = {}
    var errorHandler: () -> Void = {}
    
    // MARK: - Input Interface
    func fetchImageList() {
        usecase.getImageUrlList(mobileId: mobileData.id).done { [weak self] urlList in
            self?.imageUrlList = urlList
            self?.dataChangedHandler()
        }.catch { [weak self] error in
             self?.errorHandler()
        }
    }
    
    // MARK: - Out Interface
    func getViewTitle() -> String {
        return self.mobileData.name
    }
    
    func getViewDescription() -> String {
        return self.mobileData.description
    }
    
    func getPrice() -> String {
        return self.mobileData.priceFriendlyText
    }
    
    func getRating() -> String {
        return self.mobileData.ratingFriendlyText
    }
    
    func getImageUrlList() -> [URL] {
        if imageUrlList.count > 0 {
            return imageUrlList
        } else if let thumbUrl = mobileData.thumbnailUrl {
            return [thumbUrl]
        } else {
            return []
        }
    }
}
