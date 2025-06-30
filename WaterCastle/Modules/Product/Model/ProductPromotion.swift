struct ProductPromotion: Codable {
    let productID: String
    let titleEn: String?
    let titleAr: String?
    let descEn: String?
    let descAr: String?
    let img: [ProductPromotionImage]?

    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
        case titleEn = "title_en"
        case titleAr = "title_ar"
        case descEn = "desc_en"
        case descAr = "desc_ar"
        case img
    }
}

struct ProductPromotionImage: Codable {
    let imagePath: String

    enum CodingKeys: String, CodingKey {
        case imagePath = "image_path"
    }
}
