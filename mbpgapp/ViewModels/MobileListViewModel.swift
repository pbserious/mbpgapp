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
    
    init(uc: MobileInfoUseCaseProtocol) {
        self.usecase = uc
    }
}
