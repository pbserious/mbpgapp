//
//  mbpgappTests.swift
//  mbpgappTests
//
//  Created by Rattee Wariyawutthiwat on 5/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import XCTest

extension MobileData {
    static func getMockMobileDataJSON(id:Int) -> String {
    return """
    {
        "price": 179.9\(id),
        "brand": "Samsung",
        "name": "Mobile \(id)",
        "thumbImageURL": "https://cdn.mos.cms.futurecdn.net/grwJkAGWQp4EPpWA3ys3YC-650-80.jpg",
        "id": \(id),
        "description": "description \(id)",
        "rating": 4.\(id)
    }
    """
    }
}

class mbpgappTests: XCTestCase {
    
    private let favHelper = MockFavHelper()
    private let infoUseCase = MockInfoUseCase()
    private let idSet = [3,2,1,4]
    
    private func getHighestPrice() -> Double {
        return Double("179.9\(idSet.max()!)")!
    }
    
    private func getLowestPrice() -> Double {
        return Double("179.9\(idSet.min()!)")!
    }
    
    private func getHighestRate() -> Float {
        return Float("4.\(idSet.max()!)")!
    }
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        idSet.forEach { id in
            guard let md = MobileData(JSONString: MobileData.getMockMobileDataJSON(id: id)) else {
                return
            }
            infoUseCase.mobileList.append(md)
        }
        favHelper.favList = [1,3]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Test case
    func test_LIST_SHOW_ALL_SECTION() {
        let expectation = XCTestExpectation(description: "vm load data")
        let vm = MobileListViewModel(uc: infoUseCase, fp: favHelper)
        vm.dataChangedHandler = {
            expectation.fulfill()
        }
        vm.loadData()
        wait(for: [expectation], timeout: 0.1)
        
        XCTAssert(vm.numberOfMobileData()==infoUseCase.mobileList.count,
                  "number of data should be \(infoUseCase.mobileList.count) but \(vm.numberOfMobileData())")
    }
    
    func test_LIST_SHOW_FAV_SECTION() {
        let expectation = XCTestExpectation(description: "vm load data")
        let vm = MobileListViewModel(uc: infoUseCase, fp: favHelper)
        vm.dataChangedHandler = {
            expectation.fulfill()
        }
        vm.loadData()
        wait(for: [expectation], timeout: 0.1)
        
        vm.selectFiltering(.favourite)
        XCTAssert(vm.numberOfMobileData()==favHelper.favList.count,
                  "number of data should be \(favHelper.favList.count) but \(vm.numberOfMobileData())")
        vm.selectFiltering(.none) // Switch back to All Session
        XCTAssert(vm.numberOfMobileData()==infoUseCase.mobileList.count,
                  "number of data should be \(infoUseCase.mobileList.count) but \(vm.numberOfMobileData())")
    }
    
    func test_LIST_SORTING() {
        let expectation = XCTestExpectation(description: "vm load data")
        let vm = MobileListViewModel(uc: infoUseCase, fp: favHelper)
        vm.dataChangedHandler = {
            expectation.fulfill()
        }
        vm.loadData()
        wait(for: [expectation], timeout: 0.1)
        let fistIndexPath = IndexPath(row: 0, section: 0)
        
        // high to low test
        vm.selectSorting(.highToLow)
        XCTAssert(vm.mobileListCellViewModel(for: fistIndexPath).mobileData.price == getHighestPrice(),
                  "highest price is 179.94")
        // low to high test
        vm.selectSorting(.lowToHigh)
        XCTAssert(vm.mobileListCellViewModel(for: fistIndexPath).mobileData.price == getLowestPrice(),
                  "lowest price is 179.91")
        // rating test
        vm.selectSorting(.rating)
        XCTAssert(vm.mobileListCellViewModel(for: fistIndexPath).mobileData.rating == getHighestRate(),
                  "highest rate is 4.4")
        
        // high to low in fav section
        vm.selectSorting(.highToLow)
        vm.selectFiltering(.favourite)
        XCTAssert(vm.mobileListCellViewModel(for: fistIndexPath).mobileData.price == 179.93,
                  "highest price in fav is 179.93")
    }
    
    func test_LIST_TOGGLE_FAVOURITE() {
        let expectation = XCTestExpectation(description: "vm load data")
        let vm = MobileListViewModel(uc: infoUseCase, fp: favHelper)
        vm.dataChangedHandler = {
            expectation.fulfill()
        }
        vm.loadData()
        wait(for: [expectation], timeout: 0.1)
        let fistIndexPath = IndexPath(row: 0, section: 0)
        let lastIndexPath = IndexPath(row: idSet.count-1, section: 0)
        
        // Mock situation here mobile 3 is already favourite
        let cellVM = vm.mobileListCellViewModel(for: fistIndexPath)
        cellVM.toggleFavourite()
        
        vm.selectFiltering(.favourite)
        XCTAssert(vm.numberOfMobileData()==1, "Only one fav left")
        
        vm.selectFiltering(.none)
        let lastCellVM = vm.mobileListCellViewModel(for: lastIndexPath)
        cellVM.toggleFavourite()
        lastCellVM.toggleFavourite()
        
        vm.selectFiltering(.favourite)
        let favlist = favHelper.favList // This should contain id 1,3,4
        var checkedCount = 0
        for index in 0...vm.numberOfMobileData()-1 {
            let indexPath = IndexPath(row: index, section: 0)
            let cvm = vm.mobileListCellViewModel(for: indexPath)
            if favlist.contains(cvm.mobileData.id) {
                checkedCount += 1
            }
        }
        XCTAssert(checkedCount==3, "vm should show data with id \(favlist)")
    }
}
