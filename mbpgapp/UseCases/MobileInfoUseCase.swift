//
//  MobileInfoUseCase.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 5/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import Foundation
import Moya
import PromiseKit
import ObjectMapper

protocol MobileInfoUseCaseProtocol {
    func getMobileList() -> Promise<[MobileData]>
    func getImageUrlList(mobileId: Int) -> Promise<[URL]>
}

class MobileInfoUseCase: MobileInfoUseCaseProtocol {
    
    static let shared = MobileInfoUseCase()
    
    func getMobileList() -> Promise<[MobileData]> {
        return Promise { seal in
            let provider = MoyaProvider<MobileAPI>()
            provider.request(.getList, completion: { result in
                switch result {
                case let .success(response):
                    do {
                        let res = try response.filterSuccessfulStatusCodes()
                        if let array = try res.mapJSON() as? [[String: Any]] {
                            let list = Mapper<MobileData>().mapArray(JSONArray: array)
                            seal.fulfill(list)
                        } else {
                            seal.reject(APIError.unparsableJSON)
                        }
                    } catch {
                        seal.reject(APIError.unknownError)
                    }
                case let .failure(error):
                    seal.reject(error)
                }
            })
        }
    }
    
    func getImageUrlList(mobileId: Int) -> Promise<[URL]> {
        return Promise { seal in
            let provider = MoyaProvider<MobileAPI>()
            provider.request(.getImages(id: mobileId), completion: { result in
                switch result {
                case let .success(response):
                    do {
                        let res = try response.filterSuccessfulStatusCodes()
                        if let array = try res.mapJSON() as? [[String: Any]] {
                            let list = Mapper<MobileImageResponse>().mapArray(JSONArray: array)
                            seal.fulfill(list.compactMap({ return URL(string: $0.imageUrlString)?.httpsURL }))
                        } else {
                            seal.reject(APIError.unparsableJSON)
                        }
                    } catch {
                        seal.reject(APIError.unknownError)
                    }
                case let .failure(error):
                    seal.reject(error)
                }
            })
        }
    }
}

class MockInfoUseCase: MobileInfoUseCaseProtocol {
    
    var mobileList = [MobileData]()
    var imageList = [URL]()
    
    func getMobileList() -> Promise<[MobileData]> {
        return Promise { seal in
            seal.fulfill(mobileList)
        }
    }
    
    func getImageUrlList(mobileId: Int) -> Promise<[URL]> {
        return Promise { seal in
            seal.fulfill([])
        }
    }
}
