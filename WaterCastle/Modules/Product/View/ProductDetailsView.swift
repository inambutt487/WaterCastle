import SwiftUI
import Foundation


struct ProductDetailsView: View {
    @State var index = 0
    @Binding var show: Bool
    let product: ProductData
    var promotions: [Promotion]  = []
    @Binding var quantity: Int
    @State private var isLoading = false
    @State private var apiResult: String? = nil
    @State private var orderResponse: OrderResponse? = nil
    @State private var selectedLoyaltyProgram: RewardProgram? = nil
    @State private var promoCode: String = ""
    @State private var email: String = ""
    @State private var showPromoInput: Bool = false
    @State private var showLoyaltyDetails: Bool = false
    @State private var similarProducts: [ProductData] = []
    @State private var didLoadCart = false
    @State private var navigateToShop = false
    @State private var showLogin = false

    @StateObject private var loginVM = LoginViewModel()
    @StateObject private var productVM = ProductViewModel()


    fileprivate func NavigationBarView() -> some View {
        HStack(alignment: .center) {
            Button(action: {
                self.show.toggle()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(Constants.AppColor.secondaryBlack)
            }
            .padding(.leading, 10)
            .frame(width: 40, height: 40)
            Spacer()
            FavoriteButton()
                .padding(.trailing, 10)
        }
        .frame(width: UIScreen.main.bounds.width, height: 35)
        .overlay(
            Text(product.nameEn ?? "")
                .lineLimit(1)
                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
                .foregroundColor(Constants.AppColor.primaryBlack)
                .padding(.horizontal, 12),
            alignment: .center)
    }

    fileprivate func FavoriteButton() -> some View {
        Button(action: {}) {
            Image(systemName: "heart")
                .foregroundColor(Constants.AppColor.secondaryBlack)
                .frame(width: 35, height: 35)
        }
        .cornerRadius(20)
    }
    
    fileprivate func ImageSlider() -> some View {
            let images = product.img.compactMap { $0.imagePath }
            return PagingView(index: $index.animation(), maxIndex: max(images.count - 1, 0)) {
                ForEach(images, id: \ .self) { imageUrl in
                    let fullUrl = Constants.API.imageBaseURL + imageUrl
                    AsyncImage(url: URL(string: fullUrl)) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                }
            }
            .aspectRatio(4/3, contentMode: .fit)
        }

    private func addToCart() {
        isLoading = true
        apiResult = nil
        let request = AddToCartRequest(
            add_type: "1",
            area_id: "3444",
            address_id: "1340951",
            client_id: "1126662",
            country_id: "2229",
            cart: [
                CartItem(
                    product_price: product.price ?? "0",
                    count: String(quantity),
                    dish_id: product.id ?? "0",
                    haspromocode: false,
                    Price: product.priceVat ?? product.price ?? "0",
                    productTitleEN: product.nameEn ?? ""
                )
            ],
            fcmToken: "eESkqEwi0E12oznnvCvjJj:APA91bEbahCFSJzV8Xxl6mz6lXjJyI6cpQxQJncLxmf2jgT0enV5tbcmTBH58pSs9QstDEQLUQ_j4PMSZzvURFbnACb1uM9lScPmzq0IkuJQapJkQEkZzuM"
        )
        Task {
            let result = await productVM.addToCart(request: request)
            isLoading = false
            switch result {
            case .success(let order):
                self.orderResponse = order
                self.apiResult = nil
            case .failure(let error):
                apiResult = error.localizedDescription
            }
        }
    }

    fileprivate func AddToCartButton() -> some View {
        Button(action: {
            if UserManager.shared.user != nil {
                addToCart()
            } else {
                showLogin = true
            }
        }) {
            if isLoading {
                ProgressView()
                    .frame(height: 65)
                    .frame(minWidth: 0, maxWidth: .infinity)
            } else {
                Text("Proceed to Shop")
                    .font(.custom(Constants.AppFont.boldFont, size: 15))
                    .foregroundColor(.white)
                    .frame(height: 65)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Constants.AppColor.gradientRedHorizontal)
            }
        }
        .padding(.horizontal, 0)
        .disabled(isLoading || orderResponse == nil)
        .fullScreenCover(isPresented: $showLogin) {
            LoginView(viewModel: loginVM, onLoginSuccess: {
                showLogin = false
                navigateToShop = true
            })
        }
    }

    var body: some View {
        
        let isPromo = product.isPromoted(using: promotions)
        let matchedPromo = product.matchedPromotion(from: promotions)
        let generalMessage = orderResponse?.generalMessage
        let promotionMessage = orderResponse?.promotionMessage
        let newDeliveryFee = orderResponse?.newDeliveryFee?.first
        let minQty = generalMessage?.minQty ?? 1
        let maxQty = generalMessage?.maxQty ?? 100
        let deliveryFee = newDeliveryFee?.deliveryFee ?? ""
        let promoImageUrl = (orderResponse?.promoImageEn).flatMap { Constants.API.imageBaseURL + $0 }
        let rewardPrograms = orderResponse?.rewardPrograms ?? []
        let similarProductIds = orderResponse?.similarProducts ?? []
        let selectedLoyalty = selectedLoyaltyProgram
        
        VStack {
            NavigationBarView()
            ScrollView {
                ZStack {
                    Constants.AppColor.lightGrayColor.edgesIgnoringSafeArea(.all)
                    VStack(alignment: .leading, spacing: 16) {
                        ImageSlider()

                        // Delivery Free Message
                        if let title = generalMessage?.titleEn, let msg = generalMessage?.messageEn {
                            let displayTitle = title.replacingOccurrences(of: "#", with: msg)
                            Text(displayTitle)
                                .font(.headline)
                                .foregroundColor(.blue)
                                .padding(.horizontal, 15)
                        }
                        if let minQty = generalMessage?.minQty, let deliveryFee = newDeliveryFee?.deliveryFee {
                            Text("Min Qty: \(minQty), Delivery Fee: \(deliveryFee)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 15)
                        }

                        VStack(alignment: .leading) {
                            HStack {
                                Text(product.nameEn ?? "")
                                    .font(.custom(Constants.AppFont.semiBoldFont, size: 18))
                                    .foregroundColor(Constants.AppColor.secondaryBlack)
                                Spacer()
                            }
                            .padding(.horizontal, 15)
                            .padding(.top, 8)

                            Text(product.descriptionEn ?? "")
                                .font(.custom(Constants.AppFont.lightFont, size: 13))
                                .foregroundColor(Constants.AppColor.secondaryBlack)
                                .lineLimit(nil)
                                .padding(.horizontal, 15)
                                .padding(.top, -5)
                                .padding(.bottom, 5)

                            HStack {
                                Text("SAR \(product.displayedPrice)")
                                    .font(.custom(Constants.AppFont.boldFont, size: 14))
                                    .foregroundColor(Constants.AppColor.secondaryBlack)
                                Spacer()
                            }
                            .padding(.bottom, 8)
                            .padding(.horizontal, 15)

                            // Quantity Selector with max limit
                            HStack(spacing: 10) {
                                Button(action: { if quantity > minQty { quantity -= 1 } }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.gray)
                                }
                                TextField("Qty", value: $quantity, formatter: NumberFormatter())
                                    .frame(width: 40)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.numberPad)
                                    .onChange(of: quantity) { newValue in
                                        if quantity > maxQty { quantity = maxQty }
                                        if quantity < minQty { quantity = minQty }
                                    }
                                Button(action: { if quantity < maxQty { quantity += 1 } }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.horizontal, 15)
                        }
                        .background(Color.white)
                        .padding(.bottom, 5)

                        // Promotion Message
                        if let promoMsg = promotionMessage?.messageEn, let icon = promotionMessage?.iconEn {
                            HStack(spacing: 10) {
                                if let iconUrl = URL(string: Constants.API.imageBaseURL + icon) {
                                    AsyncImage(url: iconUrl) { img in
                                        img.resizable().frame(width: 32, height: 32)
                                    } placeholder: {
                                        Color.gray.frame(width: 32, height: 32)
                                    }
                                }
                                Text(promoMsg)
                                    .font(.subheadline)
                                    .foregroundColor(.orange)
                            }
                            .padding(.horizontal, 15)
                        }

                        // Corporate Reward View
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 8) {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.blue)
                                Text(orderResponse?.companyMessageEn ?? "")
                                    .font(.subheadline)
                            }
                            HStack {
                                TextField("Enter your email", text: $email)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Button("Verify") {
                                    // Add verify logic
                                }
                                .buttonStyle(.borderedProminent)
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                        // Select Your Reward
                        VStack(alignment: .leading, spacing: 8) {
                            if let promoImageUrl = promoImageUrl, let url = URL(string: promoImageUrl) {
                                Button(action: { showPromoInput.toggle() }) {
                                    AsyncImage(url: url) { img in
                                        img.resizable().frame(height: 60)
                                    } placeholder: {
                                        Color.gray.frame(height: 60)
                                    }
                                }
                            }
                            if showPromoInput {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Promo Code")
                                        .font(.caption)
                                    HStack {
                                        TextField("Enter Promo Code", text: $promoCode)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                        Button("Apply") {
                                            // Apply promo code logic
                                        }
                                        .buttonStyle(.borderedProminent)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                        // Select Your Loyalty Program
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Select Your Loyalty Program")
                                .font(.headline)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(rewardPrograms, id: \ .id) { program in
                                        Button(action: {
                                            selectedLoyaltyProgram = program
                                            showLoyaltyDetails = true
                                        }) {
                                            if let imgUrl = program.imageEn, let url = URL(string: Constants.API.imageBaseURL + imgUrl) {
                                                AsyncImage(url: url) { img in
                                                    img.resizable().frame(width: 48, height: 48).clipShape(Circle())
                                                } placeholder: {
                                                    Color.gray.frame(width: 48, height: 48).clipShape(Circle())
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            if showLoyaltyDetails, let selected = selectedLoyalty {
                                VStack(alignment: .leading, spacing: 8) {
                                    if let imgUrl = selected.imageEn, let url = URL(string: Constants.API.imageBaseURL + imgUrl) {
                                        AsyncImage(url: url) { img in
                                            img.resizable().frame(width: 80, height: 80)
                                        } placeholder: {
                                            Color.gray.frame(width: 80, height: 80)
                                        }
                                    }
                                    Text(selected.messageEn ?? "")
                                        .font(.subheadline)
                                    HStack {
                                        Button("Reset") {
                                            selectedLoyaltyProgram = nil
                                            showLoyaltyDetails = false
                                        }
                                        .buttonStyle(.bordered)
                                        Button("Change") {
                                            selectedLoyaltyProgram = nil
                                            showLoyaltyDetails = false
                                        }
                                        .buttonStyle(.borderedProminent)
                                    }
                                }
                                .padding(.top, 8)
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                        // Similar Products
                        if !similarProducts.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Similar Products")
                                    .font(.headline)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(similarProducts, id: \ .id) { prod in
                                            ProductView(row: prod)
                                                .frame(width: 170)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 15)
                        }

//                        // Product Details Section
//                        VStack(alignment: .leading) {
//                            Text("Product Details")
//                                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
//                                .foregroundColor(Constants.AppColor.secondaryBlack)
//                                .padding(.top, 10)
//                                .padding(.horizontal, 15)
//
//                            Text(product.descriptionEn ?? "")
//                                .font(.custom(Constants.AppFont.lightFont, size: 13))
//                                .foregroundColor(Constants.AppColor.secondaryBlack)
//                                .padding(.vertical, 8)
//                                .lineSpacing(2)
//                                .padding(.horizontal, 15)
//                                .lineLimit(nil)
//                        }
//                        .frame(minWidth: 0, maxWidth: .infinity)
//                        .background(Color.white)
//                        .padding(.top, -3)
                    }
                }
            }
            AddToCartButton()
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if !didLoadCart {
                didLoadCart = true
                addToCart()
            }
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(
            show: .constant(false),
            product: ProductData(
                id: "1",
                img: [Img(productGalleryID: 1, productID: 1, imagePath: "/images/sample.jpg", isDefault: 1)],
                bottles: 1,
                catAr: .plastic,
                catEn: .plastic,
                catKw: "plastic",
                price: "30",
                priceVat: "35",
                beforeDiscount: "40",
                material: "Plastic",
                unit: .car,
                nameAr: "منتج",
                nameEn: "Product",
                nameKw: "منتج",
                descriptionAr: "تفاصيل المنتج",
                descriptionEn: "Product Description",
                descriptionKw: "تفاصيل المنتج",
                productSortApp: "sale",
                categoryID: "123",
                status: "active",
                stock: "100",
                tagsEn: [],
                tagsAr: []
            ),
            quantity: .constant(1)
        )
    }
}

