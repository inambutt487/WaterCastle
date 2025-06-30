class HomeViewModel: ObservableObject {
    @Published var products: [ProductData] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    func fetchProducts() {
        isLoading = true
        Task {
            let result = await ProductService.shared.fetchProductsByLocation(
                addType: "1",
                areaId: "2031",
                countryId: "2229",
                customerId: "1126662",
                fcmToken: "IQAAAACy0crjAADn_0qqajU6fmYk_IooNpvuQAlncHCzP67z2zr43WKmRA4V-lx8oOt_nvwrz6A8aKvX0TiU75DY-UgQneFHXj8a7nsx0rKSR2Mfqg"
            )
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.products = response.rows ?? []
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}