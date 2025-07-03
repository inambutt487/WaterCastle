import Foundation

class ProductService {
    static let shared = ProductService()
    private init() {}
    
    func fetchProductsByLocation(
        addType: String,
        areaId: String,
        countryId: String,
        customerId: String,
        fcmToken: String
    ) async -> Result<[ProductData], Error> {
        let request = ProductListRequest(
            add_type: addType,
            area_id: areaId,
            country_id: countryId,
            customer_id: customerId,
            fcm_token: fcmToken
        )
        
        let headers = [
            "Authorization": Constants.API.companySettingsAuthKey
        ]

        let result: Result<ProductListResponse, Error> = await APIService.shared.postRequest(
            endpoint: Constants.API.getProductsByLocEndpoint,
            body: request,
            headers: headers
        )
        
        switch result {
        case .success(let response):
            return .success(response.rows ?? [])
        case .failure(let error):
            return .failure(error)
        }
    }

    func addToCart(request: AddToCartRequest) async -> Result<OrderResponse, Error> {
        let headers = [
            "Authorization": Constants.API.companySettingsAuthKey
        ]
        let result: Result<OrderResponse, Error> = await APIService.shared.postRequest(
            endpoint: "/get_cart_parameters_1",
            body: request,
            headers: headers
        )
        return result
    }

}
