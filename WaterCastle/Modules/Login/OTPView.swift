//
//  OTPView.swift
//  WaterCastle
//
//  Created by Mac on 02/07/2025.
//
import SwiftUI

struct OTPView: View {
    @ObservedObject var viewModel: LoginViewModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var nav: AppNavigationState
    var onVerifySuccess: (() -> Void)?
    @State private var digits: [String] = Array(repeating: "", count: 4)
    @FocusState private var pinFocusState: FocusPin?
    @State private var pinOne = ""
    @State private var pinTwo = ""
    @State private var pinThree = ""
    @State private var pinFour = ""

    enum FocusPin: Hashable {
        case pinOne, pinTwo, pinThree, pinFour
    }

    var body: some View {
        VStack(spacing: 24) {
            header
            phoneInfo
            otpFields
            terms
            verifyButton

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            if viewModel.isLoading {
                ProgressView()
            }

            Spacer()
        }
        .onChange(of: viewModel.otpResponse) { response in
            if let response = response, response.code == 200,
               Constants.API.companySettingsAuthKey != "060fac9a80afec9b95eb292ad884c5f5" {
                if let user = response.user?.first {
                    LocalDatabase.saveUser(user)
                    UserManager.shared.user = user
                }
                if let addresses = response.address, !addresses.isEmpty {
                    LocalDatabase.saveAddresses(addresses)
                    LocalDatabase.saveHomeAddress(addresses[0])
                }
                // Set navigation state for ProductDetailsView if needed
                if let selection = LocalDatabase.loadProductSelection() {
                    nav.selectedProduct = selection.product
                    nav.selectedPromotions = selection.promotions
                    nav.selectedQuantity = selection.quantity
                    nav.showProductDetails = true
                }
                onVerifySuccess?()
            }
        }
        // No .fullScreenCover here; navigation is handled by AppNavigationState
    }

    private var header: some View {
        HStack {
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.blue)
            }
            Spacer()
        }
        .padding(.horizontal)
    }

    private var phoneInfo: some View {
        VStack {
            Text("Confirm Your Phone Number")
                .font(.title2)
                .bold()
            HStack {
                Text("Please type the verification code sent to")
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Text("966" + viewModel.phone)
                        .underline()
                }
            }
            .font(.subheadline)
        }
    }

    private var otpFields: some View {
        HStack(spacing: 15) {
            otpTextField($pinOne, focus: .pinOne, next: .pinTwo)
            otpTextField($pinTwo, focus: .pinTwo, next: .pinThree)
            otpTextField($pinThree, focus: .pinThree, next: .pinFour)
            otpTextField($pinFour, focus: .pinFour, next: nil)
        }
        .onAppear {
            pinFocusState = .pinOne
        }
    }

    private var terms: some View {
        VStack {
            Text("By accessing our platform, you agree to our")
                .font(.footnote)
            Button(action: {
                if let url = URL(string: "https://berain.com.sa/terms") {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Terms and Conditions")
                    .underline()
            }
            .font(.footnote)
        }
    }

    private var verifyButton: some View {
        Button(action: {
            viewModel.otp = pinOne + pinTwo + pinThree + pinFour
            Task {
                let result = await viewModel.verifyOTP()
                if case .success(let response) = result, response.code == 200 {
                    if let user = response.user?.first {
                        LocalDatabase.saveUser(user)
                        UserManager.shared.user = user
                    }
                    if let addresses = response.address, !addresses.isEmpty {
                        LocalDatabase.saveAddresses(addresses)
                        LocalDatabase.saveHomeAddress(addresses[0])
                    }
                    // Set navigation state for ProductDetailsView if needed
                    if let selection = LocalDatabase.loadProductSelection() {
                        nav.selectedProduct = selection.product
                        nav.selectedPromotions = selection.promotions
                        nav.selectedQuantity = selection.quantity
                        nav.showProductDetails = true
                    }
                    onVerifySuccess?()
                }
            }
        }) {
            Text("Verify")
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.otp.count == 4 ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled((pinOne + pinTwo + pinThree + pinFour).count < 4)
        }
        .disabled(viewModel.otp.count != 4 || viewModel.isLoading)
        .padding(.horizontal)
    }

    private func updateOTP() {
        viewModel.otp = digits.joined()
    }

    // Helper to generate each OTP field
    @ViewBuilder
    private func otpTextField(_ pin: Binding<String>, focus: FocusPin, next: FocusPin?) -> some View {
        TextField("", text: pin)
            .modifier(OtpModifier(pin: pin))
            .focused($pinFocusState, equals: focus)
            .onChange(of: pin.wrappedValue) { value in
                if value.count == 1 {
                    if let next = next {
                        pinFocusState = next
                    } else {
                        pinFocusState = nil
                        viewModel.otp = pinOne + pinTwo + pinThree + pinFour
                    }
                } else if value.isEmpty {
                    switch focus {
                    case .pinTwo: pinFocusState = .pinOne
                    case .pinThree: pinFocusState = .pinTwo
                    case .pinFour: pinFocusState = .pinThree
                    default: break
                    }
                }
            }
    }
}
