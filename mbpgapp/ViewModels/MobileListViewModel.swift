//
//  MobileListViewModel.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 6/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import Foundation

class MobileListViewModel {
    
    fileprivate var usecase: MobileInfoUseCaseProtocol
    
    fileprivate var mobileList = [MobileData]()
    
    var dataChangedHandler: () -> Void = {}
    var errorHandler: () -> Void = {}
    
    
    init(uc: MobileInfoUseCaseProtocol) {
        self.usecase = uc
    }
    
    // MARK: Input Interface
    func loadData() {
        usecase.getMobileList().done { [weak self] list in
            // Handle Data did finish load here
            self?.mobileList = list
            self?.dataChangedHandler()
        }.catch { [weak self] error in
            // Handle error here
            self?.errorHandler()
        }
    }
    
    // MARK: Output Interface
    func numberOfMobileData() -> Int {
        return mobileList.count
    }
    
    func mobileData(for indexPath:IndexPath) -> MobileData {
        return mobileList[indexPath.row]
    }
}
