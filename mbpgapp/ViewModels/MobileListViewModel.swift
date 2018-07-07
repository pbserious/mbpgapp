//
//  MobileListViewModel.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 6/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import Foundation

class MobileListViewModel {
    
    enum Sorting {
        case none
        case lowToHigh
        case highToLow
        case rating
        
        var title: String {
            switch self {
            case .lowToHigh:
                return "Price low to high"
            case .highToLow:
                return "Price high to low"
            case .rating:
                return "Rating"
            default:
                return ""
            }
        }
    }
    
    fileprivate var usecase: MobileInfoUseCaseProtocol
    fileprivate var mobileList = [MobileData]()
    fileprivate var adaptedList: [MobileData] {
        switch currentSorting {
        case .none:
            return mobileList
        case .lowToHigh:
            return mobileList.sorted(by: { $0.price < $1.price })
        case .highToLow:
            return mobileList.sorted(by: { $0.price > $1.price })
        case .rating:
            return mobileList.sorted(by: { $0.rating > $1.rating })
        }
    }
    fileprivate var currentSorting:Sorting = .none
    
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
    
    func selectSorting(_ sorting:Sorting) {
        currentSorting = sorting
        dataChangedHandler()
    }
    
    // MARK: Output Interface
    func sortingOptions() -> [Sorting] {
        return [.lowToHigh, .highToLow, .rating]
    }
    
    func numberOfMobileData() -> Int {
        return adaptedList.count
    }
    
    func mobileData(for indexPath:IndexPath) -> MobileListCellViewModelProtocol {
        return MobileListCellViewModel(md: adaptedList[indexPath.row])
    }
}
