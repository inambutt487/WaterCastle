//
//  HomeViewModel.swift
//  WaterCastle
//
//  Created by Mac on 25/06/2025.
//
import Foundation

class HomeViewModel: ObservableObject {
    @Published var products: [ProductData] = []
    @Published var promotions: [Promotion] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    @MainActor
    func fetchProductsbyLoc() async {
        self.isLoading = true
        let request = ProductListRequest(
            add_type: "1",
            area_id: "2031",
            country_id: "2229",
            customer_id: "1126662",
            fcm_token: "IQAAAACy0crjAADn_0qqajU6fmYk_IooNpvuQAlncHCzP67z2zr43WKmRA4V-lx8oOt_nvwrz6A8aKvX0TiU75DY-UgQneFHXj8a7nsx0rKSR2Mfqg"
        )
        let headers = [
            "Authorization": Constants.API.companySettingsAuthKey
        ]
        let result: Result<ProductResponse, Error> = await APIService.shared.postRequest(
            endpoint: Constants.API.getProductsByLocEndpoint,
            body: request,
            headers: headers
        )
        self.isLoading = false
        switch result {
        case .success(let decoded):
            self.products = decoded.rows
            self.promotions = decoded.promotions ?? []
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
}
