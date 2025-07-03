//
//  IntroSlidesViewModel.swift
//  WaterCastle
//
//  Created by Mac on 02/07/2025.
//
import Foundation
import SwiftUI

class IntroSlidesViewModel: ObservableObject {
    @Published var slides: [IntroSlide] = [
        .init(imageName: "banner", heading: "Welcome", description: "Welcome to WaterCastle!"),
        .init(imageName: "banner2", heading: "Fast Delivery", description: "Get your water delivered fast."),
        .init(imageName: "banner3", heading: "Best Quality", description: "We provide the best quality water."),
        .init(imageName: "banner4", heading: "Easy Payment", description: "Pay easily with multiple options."),
        .init(imageName: "banner5", heading: "Start Shopping", description: "Let’s get started!")
    ]
}
