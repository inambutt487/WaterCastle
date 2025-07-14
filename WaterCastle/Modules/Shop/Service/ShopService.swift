//
//  ShopService.swift
//  WaterCastle
//
//  Created by Mac on 09/07/2025.
//


import Foundation

enum ShopServiceError: Error {
    case unauthorized
    case other(String)
}

class ShopService {
    static let shared = ShopService()
    private init() {}

    func checkout(request: CheckOutRequest) async -> Result<CheckOutResponse, Error> {
        let headers = [
            "Authorization": Constants.API.companySettingsAuthKey
        ]
        let result: Result<CheckOutResponse, Error> = await APIService.shared.postRequest(
            endpoint: Constants.API.checkoutEndpoint,
            body: request,
            headers: headers
        )
        switch result {
        case .success(let response):
            return .success(response)
        case .failure(let error):
            return .failure(error)
        }
    }

    func saveOrder(request: SaveOrderRequest) async -> Result<CheckOutResponse, Error> {
        let headers = [
            "Authorization": Constants.API.companySettingsAuthKey,
            "Content-Type": "application/json"
        ]
        let result: Result<CheckOutResponse, Error> = await APIService.shared.postRequest(
            endpoint: Constants.API.saveOrderEndpoint,
            body: request,
            headers: headers
        )
        switch result {
        case .success(let response):
            if response.code == 401 {
                return .failure(ShopServiceError.unauthorized)
            }
            return .success(response)
        case .failure(let error):
            return .failure(error)
        }
    }
}
