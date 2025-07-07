//
//  OtpModifier.swift
//  WaterCastle
//
//  Created by Mac on 07/07/2025.
//


import SwiftUI
import Combine

struct OtpModifier: ViewModifier {
    @Binding var pin: String
    var textLimit: Int = 1

    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) { _ in
                if pin.count > textLimit {
                    pin = String(pin.prefix(textLimit))
                }
            }
            .frame(width: 45, height: 45)
            .background(Color.white.cornerRadius(5))
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blue, lineWidth: 2)
            )
    }
}
