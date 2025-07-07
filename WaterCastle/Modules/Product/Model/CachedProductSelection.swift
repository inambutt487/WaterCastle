struct CachedProductSelection: Codable {
    let product: ProductData
    let promotions: [Promotion]
    let quantity: Int
}