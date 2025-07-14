//
//  NameWithDescriptionView.swift
//  WaterCastle
//
//  Created by Mac on 08/07/2025.
//
import SwiftUI

struct NameWithDescriptionView: View {
    let name: String?

    var body: some View {
        let parts = name?.splitNameAndDescription() ?? ("", "")

        VStack(alignment: .leading, spacing: 2) {
            Text(parts.title)
                .font(.headline)

            if let desc = parts.description {
                Text(desc)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
