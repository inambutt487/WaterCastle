import SwiftUI
import Foundation


struct ProductDetailsView: View {
    @EnvironmentObject var nav: AppNavigationState
    @State var index = 0
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
    @State private var shouldNavigateNow = false
    @State private var showLogin = false
    @State private var showCompanyMessageAlert = false
    @State private var loadedSelection: CachedProductSelection? = LocalDatabase.loadProductSelection()
    @State private var productDetails: ProductData? = nil
    @State private var didCallAddToCart = false
    
    @StateObject private var loginVM = LoginViewModel()
    @StateObject private var productVM = ProductViewModel()
    
    
    fileprivate func NavigationBarView() -> some View {
        HStack(alignment: .center) {
            Button(action: {
                nav.showProductDetails = false
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
            VStack(spacing: 2) {
                let nameParts = (nav.selectedProduct?.nameEn?.splitNameAndDescription() ?? ("", ""))
                
                Text(nameParts.title)
                    .lineLimit(1)
                    .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
                    .foregroundColor(Constants.AppColor.primaryBlack)
                
                if let desc = nameParts.description {
                    Text(desc)
                        .font(.custom(Constants.AppFont.lightFont, size: 12))
                        .foregroundColor(.gray)
                }
            }
                .padding(.horizontal, 12),
            alignment: .center
        )
        
        
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
        let images = nav.selectedProduct?.img.compactMap { $0.imagePath } ?? []
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
    
    private func addToCartAndNavigate(selection: CachedProductSelection) {
        isLoading = true
        apiResult = nil
        let product = selection.product
        let promotions = selection.promotions
        let request = AddToCartRequest(
            add_type: "1",
            area_id: Constants.API.defaultAreaId,
            address_id: Constants.API.defaultAddressId,
            client_id: Constants.API.defaultClientId,
            country_id: Constants.API.defaultCountryId,
            cart: [
                CartItem(
                    product_price: product.price ?? "0",
                    count: String(selection.quantity),
                    dish_id: product.id ?? "0",
                    haspromocode: false,
                    Price: product.priceVat ?? product.price ?? "0",
                    productTitleEN: product.nameEn ?? ""
                )
            ],
            fcmToken: Constants.API.defaultFCMToken
        )
        Task {
            let result = await productVM.addToCart(request: request)
            isLoading = false
            switch result {
            case .success(let order):
                self.orderResponse = order
                self.apiResult = nil
                // Handle order response code
                if order.code == 401 {
                    // Handle 401: reset navigation and show login
                    nav.resetToLogin()
                } else if order.code == 200 {
                    // Cache product and promotions
                    var cachedProducts = LocalDatabase.loadProducts() ?? []
                    if !cachedProducts.contains(where: { $0.id == product.id }) {
                        cachedProducts.append(product)
                        LocalDatabase.saveProducts(cachedProducts)
                    }
                    if !promotions.isEmpty {
                        LocalDatabase.savePromotions(promotions)
                    }
                    // Navigate to ShopView
                    navigateToShop = true
                } else {
                    // Show error message for other codes
                    apiResult = order.generalMessage?.messageEn ?? "Unknown error. Please try again."
                }
            case .failure(let error):
                apiResult = error.localizedDescription
            }
        }
    }
    
    fileprivate func AddToCartButton() -> some View {
        Button(action: {
            if navigateToShop {
                shouldNavigateNow = true
            } else {
                let selection = loadedSelection ?? CachedProductSelection(product: nav.selectedProduct!, promotions: nav.selectedPromotions, quantity: nav.selectedQuantity)
                addToCartAndNavigate(selection: selection)
            }
        }) {
            Text(navigateToShop ? "Continue to Shop" : "Proceed to Shop")
                .font(.custom(Constants.AppFont.boldFont, size: 15))
                .foregroundColor(.white)
                .frame(height: 65)
                .frame(maxWidth: .infinity)
                .background(Constants.AppColor.gradientRedHorizontal)
        }
        .disabled(isLoading)
        .fullScreenCover(isPresented: $showLogin) {
            LoginView(viewModel: loginVM, onLoginSuccess: {
                showLogin = false
            })
        }
    }
    
    
    var body: some View {
        guard let product = nav.selectedProduct else {
            return AnyView(Text("No product selected").onAppear { nav.showProductDetails = false })
        }
        let promotions = nav.selectedPromotions
        let minQty: Int = Int(CompanySettingsManager.shared.settings?.minQty ?? "") ?? 1
        let maxQty = 100 // or get from settings if available
        let initialQuantity = nav.selectedQuantity
        let isPromo = product.isPromoted(using: promotions)
        let matchedPromo = product.matchedPromotion(from: promotions)
        let generalMessage = orderResponse?.generalMessage
        let promotionMessage = orderResponse?.promotionMessage
        let newDeliveryFee = orderResponse?.newDeliveryFee?.first
        let deliveryFee = newDeliveryFee?.deliveryFee ?? ""
        let promoImageUrl = (orderResponse?.promoImageEn).flatMap { Constants.API.imageBaseURL + $0 }
        let rewardPrograms = orderResponse?.rewardPrograms ?? []
        let similarProductIds = orderResponse?.similarProducts ?? []
        let selectedLoyalty = selectedLoyaltyProgram
        
        return AnyView(
        NavigationStack{
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
                                let nameParts = product.nameEn?.splitNameAndDescription() ?? ("", "")
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(nameParts.title)
                                            .font(.custom(Constants.AppFont.semiBoldFont, size: 18))
                                            .foregroundColor(Constants.AppColor.secondaryBlack)
                                        
                                        if let desc = nameParts.description {
                                            Text(desc)
                                                .font(.custom(Constants.AppFont.lightFont, size: 13))
                                                .foregroundColor(.gray)
                                        }
                                    }
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
                                    Button(action: { if nav.selectedQuantity > minQty { nav.selectedQuantity -= 1 } }) {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.gray)
                                    }
                                    TextField("Qty", value: $nav.selectedQuantity, formatter: NumberFormatter())
                                        .frame(width: 40)
                                        .multilineTextAlignment(.center)
                                        .keyboardType(.numberPad)
                                        .onChange(of: nav.selectedQuantity) { newValue in
                                            if nav.selectedQuantity > maxQty { nav.selectedQuantity = maxQty }
                                            if nav.selectedQuantity < minQty { nav.selectedQuantity = minQty }
                                        }
                                    Button(action: { if nav.selectedQuantity < maxQty { nav.selectedQuantity += 1 } }) {
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
                                    Text("Corporate Reward")
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    // Info icon with tap action
                                    if let companyMessage = orderResponse?.companyMessageEn, !companyMessage.isEmpty {
                                        Button(action: {
                                            showCompanyMessageAlert = true
                                        }) {
                                            Image(systemName: "info.circle")
                                                .foregroundColor(.blue)
                                        }
                                    }
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
                                // HStack with image + text
                                if let promoImageUrl = promoImageUrl, let url = URL(string: promoImageUrl) {
                                    Button(action: {
                                        withAnimation {
                                            showPromoInput.toggle()
                                        }
                                    }) {
                                        HStack(spacing: 12) {
                                            AsyncImage(url: url) { img in
                                                img
                                                    .resizable()
                                                    .frame(width: 60, height: 60)
                                                    .cornerRadius(8)
                                            } placeholder: {
                                                Color.gray
                                                    .frame(width: 60, height: 60)
                                                    .cornerRadius(8)
                                            }
                                            
                                            Text("Show Promo Code")
                                                .font(.headline)
                                                .foregroundColor(.blue)
                                            
                                            Spacer()
                                            
                                            Image(systemName: showPromoInput ? "chevron.up" : "chevron.down")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(8)
                                    }
                                }
                                
                                // Promo input shown when toggled
                                if showPromoInput {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("Promo Code")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        
                                        HStack {
                                            TextField("Enter Promo Code", text: $promoCode)
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                            
                                            Button("Apply") {
                                                // Apply promo code logic here
                                            }
                                            .buttonStyle(.borderedProminent)
                                        }
                                    }
                                    .transition(.opacity.combined(with: .move(edge: .top)))
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
                                                        img.resizable().frame(width: 72, height: 72).clipShape(Circle())
                                                    } placeholder: {
                                                        Color.gray.frame(width: 72, height: 72).clipShape(Circle())
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
                        }
                        .padding(.horizontal)
                    }
                }
                AddToCartButton()
            }
            .navigationDestination(isPresented: $shouldNavigateNow) {
                ShopView()
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                if !didCallAddToCart {
                    didCallAddToCart = true
                if let cached = LocalDatabase.loadProductSelection() {
                    loadedSelection = cached
                    addToCartAndNavigate(selection: cached)
                } else {
                    let fallbackSelection = CachedProductSelection(product: product, promotions: promotions, quantity: nav.selectedQuantity)
                    addToCartAndNavigate(selection: fallbackSelection)
                    }
                }
            }
            .alert("Info", isPresented: $showCompanyMessageAlert, actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(orderResponse?.companyMessageEn ?? "")
            })
        })
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView()
            .environmentObject(AppNavigationState())
    }
}

