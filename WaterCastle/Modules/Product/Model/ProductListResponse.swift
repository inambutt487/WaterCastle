struct ProductListResponse: Codable {
    let status: Bool?
    let message: String?
    let rows: [ProductData]?
}
