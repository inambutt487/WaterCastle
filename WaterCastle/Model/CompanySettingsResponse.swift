//
//  CompanySettingsResponse.swift
//  shopcastle
//
//  Created by Mac on 18/06/2025.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let companySettingsResponse = try? JSONDecoder().decode(CompanySettingsResponse.self, from: jsonData)

import Foundation

// MARK: - CompanySettingsResponse
struct CompanySettingsResponse: Codable {
    let code: Int
    let rows: Rows

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case rows
    }
}

// MARK: - Rows
struct Rows: Codable {
    let minOrder, minQty, vat, helpLine: String
    let curAndroidVer, curIosVer, loadcityarea, lastAreaUpdatedDate: String
    let isTicketEnable, whatsApp, deleteLastOrderAddress, deleteAddresses: String
    let showVat, enableOtherChannels, feedbackOrder, feedbackOrderNumber: String
    let baseAPIURL, brandImage, fullPagePromo, fullPagePromoAr: String
    let fullPagePromoEn, enableMosque: String
    let mosqueAddress: MosqueAddress
    let areas: [Area]
    let cities: [City]
    let countries: [Country]
    let stcQitafMsgEn, stcQitafMsgAr, stcQitafMsgKw, email: String
    let showCategory: String
    let forceChangePassword: Int
    let changePasswordMessageEn, changePasswordMessageAr, tcEn, tcAr: String
    let language, currency, countryCode: String
    let country: Country
    let showRedeem: String
    let isEnableClubRegistration: Int
    let vatCertifcate, crNoEn, crNoAr, invoiceTextEn: String
    let invoiceTextAr, locationService, isShowCompleteAddress, isFavouritePlayerEnabled: String
    let isLoyaltyProgramEnabled, isGiftShopEnabled: String
    let addressLabels: [AddressLabel]
    let locationRadius, isBuyBerainPointsEnabled: Int
    let isRedeemPointsToWalletEnabled, showFocItemsCartEnabled, showGiftItemsCartEnabled, minRedeemPoints: String
    let minRedeemPointsShow: String
    let mosqueAddressNew: MosqueAddressNew
    let showLoyaltySegment: String
    let ticketCategories: [TicketCategory]
    let creditSlabs: [Int]
    let paymentMethods: [PaymentMethod]
    let enableAdvancePayment, corpSpecialDiscount, enableHomeChannel, otherCreditSlabAmount: String
    let corpSpecialDiscountQty: Int
    let corpSpecialDiscountMessage: CorpSpecialDiscountMessage
    let curAndroidVerB2B, curIosVerB2B, enableStoreRating: String
    let pages: [CorpSpecialDiscountMessage]
    let newFullPagePromo: [JSONAny]
    let tcLink: String
    let loginTcEn, loginTcAr: String

    enum CodingKeys: String, CodingKey {
        case minOrder = "min_order"
        case minQty = "min_qty"
        case vat
        case helpLine = "help_line"
        case curAndroidVer = "cur_android_ver"
        case curIosVer = "cur_ios_ver"
        case loadcityarea
        case lastAreaUpdatedDate = "last_area_updated_date"
        case isTicketEnable = "is_ticket_enable"
        case whatsApp = "whats_app"
        case deleteLastOrderAddress = "delete_last_order_address"
        case deleteAddresses = "delete_addresses"
        case showVat = "show_vat"
        case enableOtherChannels = "enable_other_channels"
        case feedbackOrder = "feedback_order"
        case feedbackOrderNumber = "feedback_order_number"
        case baseAPIURL = "base_api_url"
        case brandImage = "brand_image"
        case fullPagePromo = "full_page_promo"
        case fullPagePromoAr = "full_page_promo_ar"
        case fullPagePromoEn = "full_page_promo_en"
        case enableMosque = "enable_mosque"
        case mosqueAddress = "mosque_address"
        case areas, cities, countries
        case stcQitafMsgEn = "stc_qitaf_msg_en"
        case stcQitafMsgAr = "stc_qitaf_msg_ar"
        case stcQitafMsgKw = "stc_qitaf_msg_kw"
        case email
        case showCategory = "show_category"
        case forceChangePassword = "force_change_password"
        case changePasswordMessageEn = "change_password_message_en"
        case changePasswordMessageAr = "change_password_message_ar"
        case tcEn = "tc_en"
        case tcAr = "tc_ar"
        case language, currency
        case countryCode = "country_code"
        case country
        case showRedeem = "show_redeem"
        case isEnableClubRegistration = "is_enable_club_registration"
        case vatCertifcate = "vat_certifcate"
        case crNoEn = "cr_no_en"
        case crNoAr = "cr_no_ar"
        case invoiceTextEn = "invoice_text_en"
        case invoiceTextAr = "invoice_text_ar"
        case locationService = "location_service"
        case isShowCompleteAddress = "is_show_complete_address"
        case isFavouritePlayerEnabled = "is_favourite_player_enabled"
        case isLoyaltyProgramEnabled = "is_loyalty_program_enabled"
        case isGiftShopEnabled = "is_gift_shop_enabled"
        case addressLabels = "address_labels"
        case locationRadius = "location_radius"
        case isBuyBerainPointsEnabled = "is_buy_berain_points_enabled"
        case isRedeemPointsToWalletEnabled = "is_redeem_points_to_wallet_enabled"
        case showFocItemsCartEnabled = "show_foc_items_cart_enabled"
        case showGiftItemsCartEnabled = "show_gift_items_cart_enabled"
        case minRedeemPoints = "min_redeem_points"
        case minRedeemPointsShow = "min_redeem_points_show"
        case mosqueAddressNew = "mosque_address_new"
        case showLoyaltySegment = "show_loyalty_segment"
        case ticketCategories = "ticket_categories"
        case creditSlabs = "credit_slabs"
        case paymentMethods = "payment_methods"
        case enableAdvancePayment = "enable_advance_payment"
        case corpSpecialDiscount = "corp_special_discount"
        case enableHomeChannel = "enable_home_channel"
        case otherCreditSlabAmount = "other_credit_slab_amount"
        case corpSpecialDiscountQty = "corp_special_discount_qty"
        case corpSpecialDiscountMessage = "corp_special_discount_message"
        case curAndroidVerB2B = "cur_android_ver_b2b"
        case curIosVerB2B = "cur_ios_ver_b2b"
        case enableStoreRating = "enable_store_rating"
        case pages
        case newFullPagePromo = "new_full_page_promo"
        case tcLink = "tc_link"
        case loginTcEn = "login_tc_en"
        case loginTcAr = "login_tc_ar"
    }
}

// MARK: - AddressLabel
struct AddressLabel: Codable {
    let id: Int
    let icon: String
    let sort: Int
    let labelEn, labelAr, labelKw: String

    enum CodingKeys: String, CodingKey {
        case id, icon, sort
        case labelEn = "label_en"
        case labelAr = "label_ar"
        case labelKw = "label_kw"
    }
}

// MARK: - Area
struct Area: Codable {
    let areaID: Int
    let googleAreaEn, googleAreaAr, googleAreaKw: String
    let areaCountryID, areaCityID: Int
    let areaTitleAr, areaTitleEn, areaTitleKw: String
    let areaActive: Int
    let areaCode: String

    enum CodingKeys: String, CodingKey {
        case areaID = "area_id"
        case googleAreaEn = "google_area_en"
        case googleAreaAr = "google_area_ar"
        case googleAreaKw = "google_area_kw"
        case areaCountryID = "area_country_id"
        case areaCityID = "area_city_id"
        case areaTitleAr = "area_title_ar"
        case areaTitleEn = "area_title_en"
        case areaTitleKw = "area_title_kw"
        case areaActive = "area_active"
        case areaCode = "area_code"
    }
}

// MARK: - City
struct City: Codable {
    let cityID, cityCountryID: Int
    let cityTitleEn, cityTitleAr, cityTitleKw: String
    let plant, cityActive, enableOther: Int

    enum CodingKeys: String, CodingKey {
        case cityID = "city_id"
        case cityCountryID = "city_country_id"
        case cityTitleEn = "city_title_en"
        case cityTitleAr = "city_title_ar"
        case cityTitleKw = "city_title_kw"
        case plant
        case cityActive = "city_active"
        case enableOther = "enable_other"
    }
}

// MARK: - CorpSpecialDiscountMessage
struct CorpSpecialDiscountMessage: Codable {
    let en, ar, kw: String
    let pageID: Int?

    enum CodingKeys: String, CodingKey {
        case en, ar, kw
        case pageID = "page_id"
    }
}

// MARK: - Country
struct Country: Codable {
    let countryID: Int
    let countryNameEn, countryNameAr, countryNameKw, countryCode: String

    enum CodingKeys: String, CodingKey {
        case countryID = "country_id"
        case countryNameEn = "country_name_en"
        case countryNameAr = "country_name_ar"
        case countryNameKw = "country_name_kw"
        case countryCode = "country_code"
    }
}

// MARK: - MosqueAddress
struct MosqueAddress: Codable {
    let makkah, madina: [Madina]
    let saudiFoodbank: [SaudiFoodbank]

    enum CodingKeys: String, CodingKey {
        case makkah = "Makkah"
        case madina = "Madina"
        case saudiFoodbank = "Saudi Foodbank"
    }
}

// MARK: - Madina
struct Madina: Codable {
    let addID, sapID: String?
    let userID: Int?
    let addArea, addName, addDetail, addStreetName: String?
    let addLatitude, addLongitude, addBlock, addFloor: String?
    let addGoogleAddress, addCity: String?
    let addType: Int?
    let addCountry, latitude, longitude: String?

    enum CodingKeys: String, CodingKey {
        case addID = "add_id"
        case sapID = "sap_id"
        case userID = "user_id"
        case addArea = "add_area"
        case addName = "add_name"
        case addDetail = "add_detail"
        case addStreetName = "add_street_name"
        case addLatitude = "add_latitude"
        case addLongitude = "add_longitude"
        case addBlock = "add_block"
        case addFloor = "add_floor"
        case addGoogleAddress = "add_google_address"
        case addCity = "add_city"
        case addType = "add_type"
        case addCountry = "add_country"
        case latitude, longitude
    }
}

// MARK: - SaudiFoodbank
struct SaudiFoodbank: Codable {
    let latitude, longitude: String
}

// MARK: - MosqueAddressNew
struct MosqueAddressNew: Codable {
    let mainList: [MainList]
    let options: Options

    enum CodingKeys: String, CodingKey {
        case mainList = "main_list"
        case options
    }
}

// MARK: - MainList
struct MainList: Codable {
    let nameEn, nameAr, icon, descEn: String
    let descAr, optionKey: String

    enum CodingKeys: String, CodingKey {
        case nameEn = "name_en"
        case nameAr = "name_ar"
        case icon
        case descEn = "desc_en"
        case descAr = "desc_ar"
        case optionKey = "option_key"
    }
}

// MARK: - Options
struct Options: Codable {
    let makkah, madina, saudiFoodbank, namaaorganization: [Madina]

    enum CodingKeys: String, CodingKey {
        case makkah, madina
        case saudiFoodbank = "saudi_foodbank"
        case namaaorganization
    }
}

// MARK: - PaymentMethod
struct PaymentMethod: Codable {
    let id, titleEn, titleAr, titleKw: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case id
        case titleEn = "title_en"
        case titleAr = "title_ar"
        case titleKw = "title_kw"
        case status
    }
}

// MARK: - TicketCategory
struct TicketCategory: Codable {
    let id: Int
    let title: CorpSpecialDiscountMessage
    let status: Int
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

