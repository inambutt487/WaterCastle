
import Foundation

class ProductService {
    static let shared = ProductService()
    private init() {}
    
    func fetchProducts() async -> Result<[Product], Error> {
        guard let url = URL(string: Constants.API.baseURL + Constants.API.productsEndpoint) else {
            return .failure(APIError.invalidResponse)
        }
        
        let request = URLRequest(url: url)
        return await APIService.shared.performRequest(request)
    }
}
