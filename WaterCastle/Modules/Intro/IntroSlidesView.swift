//
//  IntroSlidesView.swift
//  WaterCastle
//
//  Created by Mac on 02/07/2025.
//


import SwiftUI

struct IntroSlidesView: View {
    @ObservedObject var viewModel: IntroSlidesViewModel
    @Binding var isFinished: Bool
    var onFinish: (() -> Void)? = nil
    @State private var currentPage = 0

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(Array(viewModel.slides.enumerated()), id: \.element.id) { index, slide in
                    VStack {
                        Spacer()
                        Image(slide.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.main.bounds.height * 0.4)
                        Spacer()
                        Text(slide.heading)
                            .font(.title)
                            .bold()
                            .padding(.top)
                        Text(slide.description)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Spacer()
                        if index == viewModel.slides.count - 1 {
                            Button(NSLocalizedString("button_finish", comment: "Finish")) {
                                isFinished = true
                                onFinish?()
                            }
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal, 40)
                        }
                        Spacer()
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}
