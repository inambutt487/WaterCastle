//
//  ProductConstraints.swift
//  WaterCastle
//
//  Created by Mac on 26/06/2025.
//

import Foundation

extension ProductData {
    
    /// Returns `true` if product is included in passed promotion list
    func isPromoted(using promotions: [Promotion]) -> Bool {
        guard let id = self.id, let pid = Int(id) else { return false }
        return promotions.contains { $0.productID?.contains(pid) == true }
    }

    /// Returns the matched promotion for this product, if any
    func matchedPromotion(from promotions: [Promotion]) -> Promotion? {
        guard let id = self.id, let pid = Int(id) else { return nil }
        return promotions.first(where: { $0.productID?.contains(pid) == true })
    }

    /// Returns promotion image if any
    func promotionImages(from promotions: [Promotion]) -> [String] {
        guard let promo = matchedPromotion(from: promotions) else { return [] }

        // You can extract more promotion image fields as needed
        var result: [String] = []
        if let img = promo.imageMobileEn { result.append(img) }
        if let img = promo.imageMobileAr { result.append(img) }
        if let img = promo.imageMobileKw { result.append(img) }
        return result
    }

    /// VAT-safe displayed price
    var displayedPrice: String {
        let vatEnabled = CompanySettingsManager.shared.settings?.showVat == "1"
        return vatEnabled ? (self.priceVat ?? self.price ?? "") : (self.price ?? "")
    }
}
