//
//  ShopViewModel.swift
//  WaterCastle
//
//  Created by Mac on 09/07/2025.
//


import Foundation

@MainActor
class ShopViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var checkOutResponse: CheckOutResponse?

    func checkout(request: CheckOutRequest) async -> Result<CheckOutResponse, Error> {
        isLoading = true
        errorMessage = nil
        let result: Result<CheckOutResponse, Error> = await ShopService.shared.checkout(request: request)
        isLoading = false
        switch result {
        case .success(let response):
            self.checkOutResponse = response
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
        return result
    }

    func saveOrder(request: SaveOrderRequest) async -> Result<CheckOutResponse, Error> {
        isLoading = true
        errorMessage = nil
        let result: Result<CheckOutResponse, Error> = await ShopService.shared.saveOrder(request: request)
        isLoading = false
        switch result {
        case .success(let response):
            self.checkOutResponse = response
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
        return result
    }
}