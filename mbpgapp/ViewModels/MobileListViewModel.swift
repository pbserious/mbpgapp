//
//  MobileListViewModel.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 6/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import Foundation

class MobileListViewModel {
    
    enum Filtering {
        case none
        case favourite
        
        var isToggleFavouriteEnable: Bool {
            switch self {
            case .none:
                return true
            default:
                return false
            }
        }
    }
    
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
    fileprivate var favHelper: FavouriteHelperProtocol
    fileprivate var mobileList = [MobileData]()
    fileprivate var adaptedList: [MobileData] {
        var result = mobileList

        // Filtering Data
        switch currentFiltering {
        case .favourite:
            let favIdList = favHelper.favouriteArray
            result = mobileList.filter({ return favIdList.contains($0.id) })
        default:
            break
        }
        
        // Sorting Data
        switch currentSorting {
        case .none:
            return result
        case .lowToHigh:
            return result.sorted(by: { $0.price < $1.price })
        case .highToLow:
            return result.sorted(by: { $0.price > $1.price })
        case .rating:
            return result.sorted(by: { $0.rating > $1.rating })
        }
    }
    
    fileprivate var currentFiltering:Filtering = .none
    fileprivate var currentSorting:Sorting = .none
    
    var loadingHandler: () -> Void = {}
    var dataChangedHandler: () -> Void = {}
    var errorHandler: ErrorMessageHandler = { _ in }    
    
    init(uc: MobileInfoUseCaseProtocol, fp:FavouriteHelperProtocol ) {
        self.usecase = uc
        self.favHelper = fp
    }
    
    // MARK: - Input Interface
    func loadData() {
        loadingHandler()
        usecase.getMobileList().done { [weak self] list in
            // Handle Data did finish load here
            self?.mobileList = list
            self?.dataChangedHandler()
        }.catch { [weak self] error in
            // Handle error here
            self?.errorHandler(error.localizedDescription)
        }
    }
    
    func selectFiltering(_ filtering:Filtering) {
        currentFiltering = filtering
        dataChangedHandler()
    }
    
    func selectSorting(_ sorting:Sorting) {
        currentSorting = sorting
        dataChangedHandler()
    }
    
    // MARK: - Output Interface
    func sortingOptions() -> [Sorting] {
        return [.lowToHigh, .highToLow, .rating]
    }
    
    func numberOfMobileData() -> Int {
        return adaptedList.count
    }
    
    func mobileListCellViewModel(for indexPath:IndexPath) -> MobileListCellViewModelProtocol {
        return MobileListCellViewModel(md: adaptedList[indexPath.row],
                                       fp: favHelper,
                                       isToggleFavouriteEnable: currentFiltering.isToggleFavouriteEnable)
    }
}
