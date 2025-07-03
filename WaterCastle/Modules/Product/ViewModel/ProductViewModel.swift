import Foundation

@MainActor
class ProductViewModel: BaseViewModel {
    @Published var products: [ProductResponse] = []
    
    func addToCart(request: AddToCartRequest) async -> Result<OrderResponse, Error> {
        return await ProductService.shared.addToCart(request: request)
    }
} 
