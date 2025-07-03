//
//  ProductResponse.swift
//  WaterCastle
//
//  Created by Mac on 24/06/2025.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productResponse = try? JSONDecoder().decode(ProductResponse.self, from: jsonData)

import Foundation

// MARK: - ProductResponse
struct ProductResponse: Codable {
    let code, minQty: Int?
    let rows: [ProductData]
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
    let title: String?
    let productID: [Int]?
    let minQuantity, addOn: Int?
    let cityID: [String]?
    let startDate, endDate: String?
    let imageWebEn, imageWebAr, imageWebKw: String?
    let imageMobileEn, imageMobileAr, imageMobileKw, promotionLevel: String?
    let isOffer, isFootball: Int?
    let link, clubIDS: String?
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
struct ProductData: Codable {
    let id: String?
    let img: [Img]
    let bottles: Int?
    let catAr, catEn: Cat?
    let catKw, price, priceVat, beforeDiscount: String?
    let material: String?
    let unit: Unit?
    let nameAr, nameEn, nameKw, descriptionAr: String?
    let descriptionEn, descriptionKw, productSortApp, categoryID: String?
    let status, stock: String?
    let tagsEn, tagsAr: [String]?

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
    let productGalleryID, productID: Int
    let imagePath: String
    let isDefault: Int

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
