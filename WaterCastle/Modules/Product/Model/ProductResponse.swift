// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productResponse = try? JSONDecoder().decode(ProductResponse.self, from: jsonData)

import Foundation

// MARK: - ProductResponse
struct ProductResponse: Codable {
    let code, minQty: Int?
    let rows: [Row]?
    let isSaafMember: Bool?
    let promotions, donationPromotion: [Promotion]?
    let sportsInformation: SportsInformation?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case minQty = "min_qty"
        case rows
        case isSaafMember = "is_saaf_member"
        case promotions
        case donationPromotion = "donation_promotion"
        case sportsInformation = "sports_information"
    }
}

// MARK: - Promotion
struct Promotion: Codable {
    let promotionID: Int?
    let title: JSONNull?
    let productID: [Int]?
    let minQuantity, addOn: Int?
    let cityID: [JSONAny]?
    let startDate, endDate: String?
    let imageWebEn, imageWebAr, imageWebKw: JSONNull?
    let imageMobileEn, imageMobileAr, imageMobileKw, promotionLevel: String?
    let isOffer, isFootball: Int?
    let link, clubIDS: JSONNull?
    let enableWithPromo, status, sort: Int?
    let info: Info?
    let createdAt: String?
    let rangeLimit: [RangeLimit]?
    let channelID, groupID: Int?
    let promotionType, onProducts, locations, giftProducts: String?
    let webImage, mobileImage, updatedAt: String?
    let countryID, multiFoc, isBanner, isDonation: Int?
    let quantity: Int?
    let infoEn, infoAr, infoKw: String?
    let focProd, focItems: [Foc]?
    let emptyFoc: Int?

    enum CodingKeys: String, CodingKey {
        case promotionID = "promotion_id"
        case title = "Title"
        case productID = "product_id"
        case minQuantity = "min_quantity"
        case addOn = "add_on"
        case cityID = "city_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case imageWebEn = "image_web_en"
        case imageWebAr = "image_web_ar"
        case imageWebKw = "image_web_kw"
        case imageMobileEn = "image_mobile_en"
        case imageMobileAr = "image_mobile_ar"
        case imageMobileKw = "image_mobile_kw"
        case promotionLevel = "promotion_level"
        case isOffer = "is_offer"
        case isFootball = "is_football"
        case link
        case clubIDS = "club_ids"
        case enableWithPromo = "enable_with_promo"
        case status, sort, info
        case createdAt = "created_at"
        case rangeLimit = "range_limit"
        case channelID = "channel_id"
        case groupID = "group_id"
        case promotionType = "promotion_type"
        case onProducts = "on_products"
        case locations
        case giftProducts = "gift_products"
        case webImage = "web_image"
        case mobileImage = "mobile_image"
        case updatedAt = "updated_at"
        case countryID = "country_id"
        case multiFoc = "multi_foc"
        case isBanner = "is_banner"
        case isDonation = "is_donation"
        case quantity
        case infoEn = "info_en"
        case infoAr = "info_ar"
        case infoKw = "info_kw"
        case focProd = "foc_prod"
        case focItems = "foc_items"
        case emptyFoc = "empty_foc"
    }
}

// MARK: - Foc
struct Foc: Codable {
    let nameEn, nameAr, nameKw: String?
    let id: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case nameEn = "name_en"
        case nameAr = "name_ar"
        case nameKw = "name_kw"
        case id, image
    }
}

// MARK: - Info
struct Info: Codable {
    let textEn, textAr, imageEn, imageAr: String?
    let focTitleEn, focTitleAr: String?

    enum CodingKeys: String, CodingKey {
        case textEn = "text_en"
        case textAr = "text_ar"
        case imageEn = "image_en"
        case imageAr = "image_ar"
        case focTitleEn = "foc_title_en"
        case focTitleAr = "foc_title_ar"
    }
}

// MARK: - RangeLimit
struct RangeLimit: Codable {
    let min, max, addOn, param1: String?
    let param2, param3, param4, amount: String?
    let focitems: [Focitem]?

    enum CodingKeys: String, CodingKey {
        case min, max
        case addOn = "add_on"
        case param1, param2, param3, param4, amount, focitems
    }
}

// MARK: - Focitem
struct Focitem: Codable {
    let pid, qty: String?

    enum CodingKeys: String, CodingKey {
        case pid
        case qty = "Qty"
    }
}

// MARK: - Row
struct Row: Codable {
    let id: String?
    let img: [Img]?
    let bottles: Int?
    let catAr, catEn: Cat?
    let catKw, price, priceVat, beforeDiscount: String?
    let material: String?
    let unit: Unit?
    let nameAr, nameEn, nameKw, descriptionAr: String?
    let descriptionEn, descriptionKw, productSortApp, categoryID: String?
    let status, stock: String?
    let tagsEn, tagsAr: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case id, img, bottles
        case catAr = "cat_ar"
        case catEn = "cat_en"
        case catKw = "cat_kw"
        case price
        case priceVat = "price_vat"
        case beforeDiscount = "before_discount"
        case material, unit
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case nameKw = "name_kw"
        case descriptionAr = "description_ar"
        case descriptionEn = "description_en"
        case descriptionKw = "description_kw"
        case productSortApp = "product_sort_app"
        case categoryID = "category_id"
        case status, stock
        case tagsEn = "tags_en"
        case tagsAr = "tags_ar"
    }
}

enum Cat: String, Codable {
    case plastic = "Plastic"
}

// MARK: - Img
struct Img: Codable {
    let productGalleryID, productID: Int?
    let imagePath: String?
    let isDefault: Int?

    enum CodingKeys: String, CodingKey {
        case productGalleryID = "product_gallery_id"
        case productID = "product_id"
        case imagePath = "image_path"
        case isDefault = "is_default"
    }
}

enum Unit: String, Codable {
    case car = "CAR"
    case zsr = "ZSR"
}

// MARK: - SportsInformation
struct SportsInformation: Codable {
    let registerNowEn, registerNowAr, redirectURL, thanksMsgEn: String?
    let thanksMsgAr, registerFormEn, registerFormAr: String?
    let footballClubs: [FootballClub]?
    let footballTerms: String?
    let isSaafMember: Bool?
    let editTextFeildsBgColor, textLabelColor, buttonBgColor, joinLaterTextColor: String?
    let hintEditTextColor, buttonTextColor, backIconColor, unSelectedTermsConditionsCheckboxColorBg: String?
    let selectedTermsConditionsCheckboxColorBg, unSelectedGenderRadioBtnColorBg, selectedGenderRadioBtnColorBg, disableSaveBtnBg: String?
    let disableSaveBtnTextColor: String?
    let allowClubInput: Int?
    let sportFormTitleColor: String?
    let ageRange: [AgeRange]?

    enum CodingKeys: String, CodingKey {
        case registerNowEn = "register_now_en"
        case registerNowAr = "register_now_ar"
        case redirectURL = "redirect_url"
        case thanksMsgEn = "thanks_msg_en"
        case thanksMsgAr = "thanks_msg_ar"
        case registerFormEn = "register_form_en"
        case registerFormAr = "register_form_ar"
        case footballClubs = "football_clubs"
        case footballTerms = "football_terms"
        case isSaafMember = "is_saaf_member"
        case editTextFeildsBgColor = "edit_text_feilds_bg_color"
        case textLabelColor = "text_label_color"
        case buttonBgColor = "button_bg_color"
        case joinLaterTextColor = "join_later_text_color"
        case hintEditTextColor = "hint_edit_text_color"
        case buttonTextColor = "button_text_color"
        case backIconColor = "back_icon_color"
        case unSelectedTermsConditionsCheckboxColorBg = "un_selected_terms_conditions_checkbox_color_bg"
        case selectedTermsConditionsCheckboxColorBg = "selected_terms_conditions_checkbox_color_bg"
        case unSelectedGenderRadioBtnColorBg = "un_selected_gender_radio_btn_color_bg"
        case selectedGenderRadioBtnColorBg = "selected_gender_radio_btn_color_bg"
        case disableSaveBtnBg = "disable_save_btn_bg"
        case disableSaveBtnTextColor = "disable_save_btn_text_color"
        case allowClubInput = "allow_club_input"
        case sportFormTitleColor = "sport_form_title_color"
        case ageRange = "age_range"
    }
}

// MARK: - AgeRange
struct AgeRange: Codable {
    let id: Int?
    let ageTitleEn, ageTitleAr: String?

    enum CodingKeys: String, CodingKey {
        case id
        case ageTitleEn = "ageTitle_en"
        case ageTitleAr = "ageTitle_ar"
    }
}

// MARK: - FootballClub
struct FootballClub: Codable {
    let id: Int?
    let nameEn, nameAr: String?

    enum CodingKeys: String, CodingKey {
        case id
        case nameEn = "name_en"
        case nameAr = "name_ar"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if container.decodeNil() {
                    return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if let value = try? container.decodeNil() {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                    return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                    let value = try decode(from: &container)
                    arr.append(value)
            }
            return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                    let value = try decode(from: &container, forKey: key)
                    dict[key.stringValue] = value
            }
            return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                    if let value = value as? Bool {
                            try container.encode(value)
                    } else if let value = value as? Int64 {
                            try container.encode(value)
                    } else if let value = value as? Double {
                            try container.encode(value)
                    } else if let value = value as? String {
                            try container.encode(value)
                    } else if value is JSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = JSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is JSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                    try container.encode(value)
            } else if let value = value as? Int64 {
                    try container.encode(value)
            } else if let value = value as? Double {
                    try container.encode(value)
            } else if let value = value as? String {
                    try container.encode(value)
            } else if value is JSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                    self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try JSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: JSONCodingKey.self)
                    try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try JSONAny.encode(to: &container, value: self.value)
            }
    }
}
