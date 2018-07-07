//
//  FavouriteHelper.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 7/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import Foundation

fileprivate let FAV_ARRAY_KEY = "FAV_ARRAY_KEY"

class FavouriteHelper {
    
    static let shared = FavouriteHelper()
    
    private var favouriteArray: [Int] {
        return UserDefaults.standard.array(forKey: FAV_ARRAY_KEY) as? [Int] ?? []
    }
    
    private func updateFavouriteArray(_ arr:[Int]) {
        UserDefaults.standard.set(arr, forKey: FAV_ARRAY_KEY)
    }
    
    // MARK: - Interface
    // Favourite new mobile id
    func favouriteMobile(for id:Int) {
        var arr = favouriteArray
        if !arr.contains(id) {
            arr.append(id)
            updateFavouriteArray(arr)
        }
    }
    
    // Unfavourite new mobile id
    func unfavouriteMobile(for id:Int) {
        var arr = favouriteArray
        
        var removedIndex: Int?
        for index in 0...arr.count-1 {
            if id == arr[index] {
                removedIndex = index
            }
        }
        if let index = removedIndex {
            arr.remove(at: index)
            updateFavouriteArray(arr)
        }
    }
    
    // Get all favourite list
    func getFavouriteList() -> [Int] {
        return favouriteArray
    }
    
    // check wheter specific id is favourite
    func isFavourite(for id:Int) -> Bool {
        return favouriteArray.contains(id)
    }
    
}
