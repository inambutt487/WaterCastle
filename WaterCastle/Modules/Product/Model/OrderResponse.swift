import Foundation

// MARK: - OrderResponse
struct OrderResponse: Codable {
    let code, isValidOrder: Int?
    let duplicateOrders: String?
    let latestOrders: [JSONAny]?
    let showReferral, showStcTamayouz, stcTamayouzMinQty, defaultPromo: String?
    let promoObject: PromoObject?
    let deliveryCharges, saffMsgEn, saffMsgAr: String?
    let remainingQtySaff: Int?
    let isSaffMember: Bool?
    let checkoutMsgEn, checkoutMsgAr: String?
    let showPromoField: Int?
    let loyaltyFocItems, loyaltyGiftItems: [JSONAny]?
    let rewardPrograms: [RewardProgram]?
    let promotionMessage: PromotionMessage?
    let generalMessage: GeneralMessage?
    let newDeliveryFee: [NewDeliveryFee]?
    let similarProducts: [Int]?
    let isCompanyUser: Int?
    let tamaraURL: String?
    let tamaraAuthToken, tamaraPublicKey, companyMessageEn, companyMessageAr: String?
    let promoImageEn, promoImageAr, stcTamayouzImageEn, stcTamayouzImageAr: String?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case isValidOrder = "is_valid_order"
        case duplicateOrders = "duplicate_orders"
        case latestOrders = "latest_orders"
        case showReferral = "show_referral"
        case showStcTamayouz = "show_stc_tamayouz"
        case stcTamayouzMinQty = "stc_tamayouz_min_qty"
        case defaultPromo = "default_promo"
        case promoObject = "promo_object"
        case deliveryCharges = "delivery_charges"
        case saffMsgEn = "saff_msg_en"
        case saffMsgAr = "saff_msg_ar"
        case remainingQtySaff = "remaining_qty_saff"
        case isSaffMember = "is_saff_member"
        case checkoutMsgEn = "checkout_msg_en"
        case checkoutMsgAr = "checkout_msg_ar"
        case showPromoField = "show_promo_field"
        case loyaltyFocItems = "loyalty_foc_items"
        case loyaltyGiftItems = "loyalty_gift_items"
        case rewardPrograms = "reward_programs"
        case promotionMessage = "promotion_message"
        case generalMessage = "general_message"
        case newDeliveryFee = "new_delivery_fee"
        case similarProducts = "similar_products"
        case isCompanyUser = "is_company_user"
        case tamaraURL = "tamara_url"
        case tamaraAuthToken = "tamara_auth_token"
        case tamaraPublicKey = "tamara_public_key"
        case companyMessageEn = "company_message_en"
        case companyMessageAr = "company_message_ar"
        case promoImageEn = "promo_image_en"
        case promoImageAr = "promo_image_ar"
        case stcTamayouzImageEn = "stc_tamayouz_image_en"
        case stcTamayouzImageAr = "stc_tamayouz_image_ar"
    }
}

// MARK: - GeneralMessage
struct GeneralMessage: Codable {
    let titleEn, titleAr, messageEn, messageAr: String?
    let minQty, maxQty: Int?
    let iconEn, iconAr: String?

    enum CodingKeys: String, CodingKey {
        case titleEn = "title_en"
        case titleAr = "title_ar"
        case messageEn = "message_en"
        case messageAr = "message_ar"
        case minQty = "min_qty"
        case maxQty = "max_qty"
        case iconEn = "icon_en"
        case iconAr = "icon_ar"
    }
}

// MARK: - NewDeliveryFee
struct NewDeliveryFee: Codable {
    let min, max: Int?
    let deliveryFee: String?

    enum CodingKeys: String, CodingKey {
        case min, max
        case deliveryFee = "delivery_fee"
    }
}

// MARK: - PromoObject
struct PromoObject: Codable {
}

// MARK: - PromotionMessage
struct PromotionMessage: Codable {
    let titleEn, titleAr, messageEn, messageAr: String?
    let minQty, maxQty, iconEn, iconAr: String?

    enum CodingKeys: String, CodingKey {
        case titleEn = "title_en"
        case titleAr = "title_ar"
        case messageEn = "message_en"
        case messageAr = "message_ar"
        case minQty = "min_qty"
        case maxQty = "max_qty"
        case iconEn = "icon_en"
        case iconAr = "icon_ar"
    }
}

// MARK: - RewardProgram
struct RewardProgram: Codable {
    let id: Int?
    let name: Message?
    let factor: Double?
    let offerPoints, offerAmount: Int?
    let message: Message?
    let image, imageEn, imageAr, messageEn: String?
    let messageAr: String?

    enum CodingKeys: String, CodingKey {
        case id, name, factor
        case offerPoints = "offer_points"
        case offerAmount = "offer_amount"
        case message, image
        case imageEn = "image_en"
        case imageAr = "image_ar"
        case messageEn = "message_en"
        case messageAr = "message_ar"
    }
}

// MARK: - Message
struct Message: Codable {
    let en, ar: String?
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