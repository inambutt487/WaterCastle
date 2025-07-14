import SwiftUI
import PartialSheet

struct ShopView: View {
    @StateObject private var viewModel = ShopViewModel()
    @State private var isModalPresented: Bool = false
    @State private var sortedBy: String = "Price: lowest to high"
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var nav: AppNavigationState
    
    @State private var isLoading = false
    @State private var checkOutResponse: CheckOutResponse? = nil
    @State private var errorMessage: String? = nil
    @State private var selectedNewDeliverySlot: New_delivery_slots? = nil
    @State private var selectedCompany: Companies? = nil
    @State private var selectedPaymentMethod: Payment_methods? = nil
    @State private var isAddressSheetPresented = false
    @State private var selectedAddress: Address? = LocalDatabase.loadHomeAddress()
    @State private var addressList: [Address] = LocalDatabase.loadAddresses() ?? []
    @State private var selectedDeliveryDate: New_delivery_slots? = nil
    @State private var selectedTimeSlot: TimeElement? = nil
    // Removed: @State private var navigateToMain = false

    
    fileprivate func NavigationBarView() -> some View {
        HStack {
            Text("")
        }
        .frame(width: UIScreen.main.bounds.width, height: 45)
        .overlay(
            Text("Shopping")
                .font(.headline)
                .padding(.horizontal, 10)
                .background(Color.init(hex: "f9f9f9"))
            , alignment: .center)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.init(hex: "f9f9f9")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    if isLoading {
                        ProgressView("Loading checkout...")
                            .padding()
                    } else if let error = errorMessage {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .padding()
                    } else if let response = checkOutResponse {
                        // Home Address section
                        if let address = selectedAddress {
                            HStack(alignment: .center) {
                                Spacer()
                                Image(systemName: "house")
                                    .foregroundColor(.blue)
                                    .padding(.top, 2)
                                VStack(alignment: .center, spacing: 2) {
                                    HStack {
                                        Text("Home Address")
                                            .font(.headline)
                                    }
                                    Text(address.add_name ?? "-")
                                        .font(.subheadline)
                                        .multilineTextAlignment(.center)
                                    HStack {
                                        Text(address.add_detail ?? "-")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .multilineTextAlignment(.center)
                                        Button(action: {
                                            print("Change tapped")
                                            print("Address count: \(addressList.count)")
                                            isAddressSheetPresented = true
                                        }) {
                                            Text("Change")
                                                .font(.caption)
                                                .foregroundColor(.blue)
                                        }
                                    }
                                    
                                }
                                Spacer()
                            }
                            .padding(.vertical, 8)
                        }
                        
                        // Delivery Time View
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "clock")
                                Text("Select Delivery Time")
                                    .font(.headline)
                            }
                            .padding(.bottom, 4)
                            // Step 1: Show dates
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(response.newDeliverySlots ?? [], id: \ .days) { slot in
                                        Button(action: {
                                            selectedDeliveryDate = slot
                                            selectedTimeSlot = nil // reset time slot when date changes
                                        }) {
                                            Text(slot.days ?? "-")
                                                .font(.subheadline)
                                                .padding(8)
                                                .background(selectedDeliveryDate?.days == slot.days ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                                                .cornerRadius(8)
                                        }
                                    }
                                }
                            }
                            // Step 2: Show time slots for selected date
                            if let selectedDate = selectedDeliveryDate, let times = selectedDate.time, !times.isEmpty {
                                Text("Select Time Slot")
                                    .font(.subheadline)
                                    .padding(.top, 8)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(times, id: \ .id) { t in
                                            Button(action: {
                                                selectedTimeSlot = t
                                            }) {
                                                Text(t.time?.en ?? "-")
                                                    .font(.caption)
                                                    .padding(8)
                                                    .background(selectedTimeSlot?.id == t.id ? Color.blue.opacity(0.5) : Color.gray.opacity(0.1))
                                                    .foregroundColor(selectedTimeSlot?.id == t.id ? .white : .primary)
                                                    .cornerRadius(8)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 8)
                        
                        // Redeem Voucher View
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "gift")
                                Text("Redeem Voucher")
                                    .font(.headline)
                            }
                            .padding(.bottom, 4)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(response.companies ?? [], id: \ .id) { company in
                                        Button(action: {
                                            selectedCompany = company
                                        }) {
                                            VStack {
                                                if let logoPath = company.logo {
                                                    let logoURLString = logoPath.hasPrefix("http") ? logoPath : Constants.API.imageBaseURL + logoPath
                                                    if let url = URL(string: logoURLString) {
                                                        AsyncImage(url: url) { image in
                                                            image.resizable().scaledToFit()
                                                        } placeholder: {
                                                            ProgressView()
                                                        }
                                                        .frame(width: 40, height: 40)
                                                    } else {
                                                        Image(systemName: "building.2")
                                                            .resizable()
                                                            .frame(width: 40, height: 40)
                                                    }
                                                } else {
                                                    Image(systemName: "building.2")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                }
                                                Text(company.name_en ?? "-")
                                                    .font(.caption2)
                                            }
                                            .padding(8)
                                            .background(selectedCompany?.id == company.id ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                                            .cornerRadius(8)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 8)
                        
                        // Payment Method View
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "creditcard")
                                Text("Payment Method")
                                    .font(.headline)
                            }
                            .padding(.bottom, 4)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(response.paymentMethods ?? [], id: \ .id) { method in
                                        Button(action: {
                                            selectedPaymentMethod = method
                                        }) {
                                            VStack {
                                                if let logoPath = method.title_en, logoPath.hasSuffix(".png") || logoPath.hasSuffix(".jpg") || logoPath.hasSuffix(".jpeg") {
                                                    let logoURLString = logoPath.hasPrefix("http") ? logoPath : Constants.API.imageBaseURL + logoPath
                                                    if let url = URL(string: logoURLString) {
                                                        AsyncImage(url: url) { image in
                                                            image.resizable().scaledToFit()
                                                        } placeholder: {
                                                            ProgressView()
                                                        }
                                                        .frame(width: 40, height: 40)
                                                    } else {
                                                        Image(systemName: "creditcard")
                                                            .resizable()
                                                            .frame(width: 40, height: 40)
                                                    }
                                                } else {
                                                    Image(systemName: "creditcard")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                }
                                                Text(method.title_en ?? "-")
                                                    .font(.caption2)
                                            }
                                            .padding(8)
                                            .background(selectedPaymentMethod?.id == method.id ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                                            .cornerRadius(8)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 8)
                        
                        // Order Summary View
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Order Summary")
                            .font(.headline)
                            // Load cart data from LocalDatabase
                            let cachedSelection = LocalDatabase.loadProductSelection()
                            let product = cachedSelection?.product
                            let quantity = cachedSelection?.quantity ?? 1
                            let price = Double(product?.price ?? "0") ?? 0.0
                            let priceVat = Double(product?.priceVat ?? "0") ?? 0.0
                            let deliveryCharges = Double(response.deliveryCharges ?? "0") ?? 0.0
                            let actualPrice = price * Double(quantity)
                            let vat = priceVat * Double(quantity)
                            let total = actualPrice + vat + deliveryCharges
                            if let product = product {
                                HStack {
                                    Text(product.nameEn ?? "-")
                                    Spacer()
                                    Text("x\(quantity)")
                                    Text(String(format: "$%.2f", price))
                                }
                            }
                            Divider()
                            HStack {
                                Text("Delivery Charges")
                                Spacer()
                                Text(String(format: "$%.2f", deliveryCharges))
                            }
                            HStack {
                                Text("VAT")
                                Spacer()
                                Text(String(format: "$%.2f", vat))
                            }
                            HStack {
                                Text("Total")
                                    .fontWeight(.bold)
                                Spacer()
                                Text(String(format: "$%.2f", total))
                            }
                        }
                        .padding(.vertical, 8)
                        
                        Spacer()
                        Button(action: {
                            // Checkout action: build SaveOrderRequest and call API
                            guard let address = selectedAddress,
                                  let cachedSelection = LocalDatabase.loadProductSelection(),
                                  let user = LocalDatabase.loadUser(),
                                  let selectedPaymentMethod = selectedPaymentMethod else {
                                errorMessage = "Missing required data."
                                return
                            }
                            let product = cachedSelection.product
                            let quantity = cachedSelection.quantity
                            let price = product.price ?? "0"
                            let priceVat = product.priceVat ?? "0"
                            let now = Date()
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let checkoutTime = formatter.string(from: now)
                            let preferedDate = selectedDeliveryDate?.days ?? ""
                            let preferedTime = selectedTimeSlot?.time?.en ?? ""
                            let companyId = selectedCompany?.id
                            let cartItem = SaveOrderCartItem(
                                count: quantity,
                                dish_id: product.id ?? "",
                                price: price,
                                productTitleEn: product.nameEn ?? "",
                                product_price: price
                            )
                            let request = SaveOrderRequest(
                                addressData: address,
                                amount: String(format: "%.2f", (Double(price) ?? 0.0) * Double(quantity)),
                                amount_vat: String(format: "%.2f", (Double(priceVat) ?? 0.0) * Double(quantity)),
                                cart: [cartItem],
                                checkout_time: checkoutTime,
                                prefered_date: preferedDate,
                                prefered_time: preferedTime,
                                payment_id: selectedPaymentMethod.id ?? "",
                                payment_type: selectedPaymentMethod.id ?? "",
                                company_id: companyId
                            )
                            isLoading = true
                            errorMessage = nil
                            Task {
                                let result = await viewModel.saveOrder(request: request)
                                isLoading = false
                                switch result {
                                case .success(let response):
                                    checkOutResponse = response
                                    addressList = LocalDatabase.loadAddresses() ?? []
                                    if let code = response.code, code == 200 {
                                        // On successful checkout, reset navigation state
                                        nav.showProductDetails = false
                                        nav.selectedProduct = nil
                                        nav.selectedPromotions = []
                                        nav.selectedQuantity = 1
                                        // Optionally, you can add a flag in AppNavigationState to show a success screen
                                    } else if addressList.count > 0 {
                                        isAddressSheetPresented = true
                                    }
                                case .failure(let error):
                                    errorMessage = error.localizedDescription
                                }
                            }
                        }) {
                            Text("Checkout")
                                .frame(maxWidth: .infinity)
                            .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.vertical, 16)
                    } else {
                        Text("No checkout result yet.")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                // Build cart from product selection
                if let cachedSelection = LocalDatabase.loadProductSelection() {
                    let product = cachedSelection.product
                    let quantity = cachedSelection.quantity
                    let cartItem = ShopCartItem(
                        product_price: product.price ?? "0",
                        count: String(quantity),
                        dish_id: product.id ?? "0",
                        haspromocode: false,
                        Price: product.priceVat ?? product.price ?? "0",
                        productTitleEN: product.nameEn ?? ""
                    )
                       let sampleRequest = CheckOutRequest(
                           area_id: Constants.API.defaultAreaId,
                           address_id: Constants.API.defaultAddressId,
                           client_id: Constants.API.defaultClientId,
                           country_id: Constants.API.defaultCountryId,
                        cart: [cartItem],
                           fcmToken: Constants.API.defaultFCMToken
                       )
                       isLoading = true
                       errorMessage = nil
                       Task {
                           let result = await viewModel.checkout(request: sampleRequest)
                           isLoading = false
                           switch result {
                           case .success(let response):
                               checkOutResponse = response
                            
                           case .failure(let error):
                               errorMessage = error.localizedDescription
                           }
                       }
                } else {
                    errorMessage = "No product selected."
                }
            }
            .sheet(isPresented: $isAddressSheetPresented) {
                VStack(alignment: .leading) {
                    Text("Select Address")
                        .font(.headline)
                        .padding()
                    Divider()
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(addressList, id: \.add_id) { address in
                                Button(action: {
                                    selectedAddress = address
                                    LocalDatabase.saveHomeAddress(address)
                                    
                                }) {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(address.add_name ?? "-")
                                            .font(.subheadline)
                                        Text(address.add_detail ?? "-")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(address.add_id == selectedAddress?.add_id ? Color.blue.opacity(0.15) : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    Spacer()
                    Button("Close") {
                        isAddressSheetPresented = false
                    }
                    .padding()
                    .onAppear {
                                   // Always refresh the address list when sheet is opened
                                   addressList = LocalDatabase.loadAddresses() ?? []
                               }
                }
            }
        }
        .partialSheet(isPresented: $isModalPresented) {
            VStack {
                Text("Sort By")
                    .font(.headline)
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    Button(action: {
                        // Do some action
                        self.isModalPresented = false
                        self.sortedBy = "Popular"
                    }) {
                        Text("Popular")
                            .padding()
                            .foregroundColor(.black)
                            .font(.body)
                        Spacer()
                    }
                    
                    Button(action: {
                        // Do some action
                        self.isModalPresented = false
                        self.sortedBy = "Newest"
                        
                    }) {
                        Text("Newest")
                            .padding()
                            .foregroundColor(.black)
                            .font(.body)
                    }
                    
                    Button(action: {
                        // Do some action
                        self.isModalPresented = false
                        self.sortedBy = "Customer review"
                        
                    }) {
                        Text("Customer review")
                            .padding()
                            .foregroundColor(.black)
                            .font(.body)
                    }
                    
                    Button(action: {
                        // Do some action
                        self.isModalPresented = false
                        self.sortedBy = "Price: lowest to high"
                        
                    }) {
                        Text("Price: lowest to high")
                            .padding()
                            .foregroundColor(.black)
                            .font(.body)
                    }
                    
                    Button(action: {
                        // Do some action
                        self.isModalPresented = false
                        self.sortedBy = "Price: highest to low"
                        
                    }) {
                        Text("Price: highest to low")
                            .padding()
                            .foregroundColor(.black)
                            .font(.body)
                    }
                }.padding(.leading, 10)
            }
        }
        // Removed NavigationLink to MainController
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .environmentObject(AppNavigationState())
    }
}
