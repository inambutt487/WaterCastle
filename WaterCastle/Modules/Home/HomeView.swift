import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var index = 0
    @EnvironmentObject var nav: AppNavigationState
    private let arrImage = ["collage", "collage", "collage", "collage"]
    var onProductTap: ((ProductData, [Promotion], Int) -> Void)? = nil

    var body: some View {
        NavigationView {
            VStack {
                NavigationBarView()
                ScrollView {
                    VStack(spacing: 20) {
                        ImageSlider()
                        
                        if viewModel.isLoading {
                            ProgressView("Loading...")
                                .padding()
                        } else if let error = viewModel.errorMessage {
                            Text("Error: \(error)")
                                .foregroundColor(.red)
                                .padding()
                        } else {
                            BerainProducts()
                            //TrendingView()
                        }
                    }
                }
            }
            .onAppear {
                Task {
                       await viewModel.fetchProductsbyLoc()
                   }
            }
            .navigationBarHidden(true)
        }
    }

    // MARK: - Navigation Bar
    private func NavigationBarView() -> some View {
        HStack {
            Spacer()
            Button(action: {
                print("Notification tapped")
            }) {
                Image(systemName: "bell")
                    .foregroundColor(Constants.AppColor.secondaryBlack)
            }
            .frame(height: 30)
        }
        .padding(.horizontal, 15)
        .frame(height: 35)
        .overlay(
            Text("Home")
                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
                .foregroundColor(Constants.AppColor.primaryBlack)
        )
    }

    // MARK: - Image Slider
    private func ImageSlider() -> some View {
        let promoImages: [String] = viewModel.promotions.flatMap { promo in
            [promo.imageMobileEn, promo.imageMobileAr, promo.imageMobileKw]
                .compactMap { $0 }
                .map { Constants.API.imageBaseURL + $0 }
        }
        let images = promoImages.isEmpty ? arrImage : promoImages
        return PagingView(index: $index.animation(), maxIndex: images.count - 1) {
            ForEach(images, id: \.self) { image in
                if image.hasPrefix("http") {
                    AsyncImage(url: URL(string: image)) { img in
                        img.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: 210)
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                } else {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: 210)
                }
            }
        }
        .aspectRatio(contentMode: .fill)
        .frame(height: 210)
    }

    // MARK: - Berain Products
    private func BerainProducts() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeader(title: "Sale", subtitle: "Festive Season Sale")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.products, id: \.id) { product in
                        ProductView(row: product, onProductTap: onProductTap)
                    }
                }
                .padding(.leading)
            }
        }
    }

    // MARK: - TaniaWater Products
    private func TaniaWaterProducts() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeader(title: "Trending", subtitle: "You have never seen it before")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.products, id: \.id) { product in
                        ProductView(row: product)
                                   }
                }
                .padding(.leading)
            }
        }
    }

    // MARK: - Section Header Reusable View
    private func SectionHeader(title: String, subtitle: String) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.custom(Constants.AppFont.boldFont, size: 18))
                    .foregroundColor(Constants.AppColor.secondaryBlack)
                Text(subtitle)
                    .font(.custom(Constants.AppFont.semiBoldFont, size: 11))
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: {}) {
                Text("VIEW ALL")
                    .font(.custom(Constants.AppFont.semiBoldFont, size: 12))
                    .foregroundColor(Constants.AppColor.secondaryRed)
            }
        }
        .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppNavigationState())
    }
}
