import Foundation

@MainActor
class ProductViewModel: BaseViewModel {
    @Published var products: [Product] = []
    
    func loadProducts() {
        isLoading = true
        clearError()
        
        Task {
            let result = await ProductService.shared.fetchProducts()
            
            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
                handleError(error)
            }
            
            isLoading = false
        }
    }
} 
