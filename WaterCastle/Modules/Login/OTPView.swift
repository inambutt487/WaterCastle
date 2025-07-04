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
    var onVerifySuccess: (() -> Void)? // Optional closure for external handling

    @FocusState private var focusedField: OTPField?
    @State private var digits: [String] = Array(repeating: "", count: 4) // State for individual digits
    @State private var showShop = false

    // Enum to represent each OTP field for FocusState
    enum OTPField: Int, CaseIterable, Hashable {
        case field0 = 0, field1, field2, field3
    }

    var body: some View {
        VStack(spacing: 24) {
            // Back Button
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding(.horizontal)

            Text("Confirm Your Phone Number")
                .font(.title2)
                .bold()

            HStack {
                Text("Please type the verification code sent to")
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Text(viewModel.phone)
                        .underline()
                }
            }
            .font(.subheadline)

            // 4-digit OTP Fields (NEW IMPLEMENTATION - replaces your single TextField)
            HStack(spacing: 12) {
                ForEach(0..<4) { index in
                    TextField("", text: Binding(
                        get: { self.digits[index] },
                        set: { newValue in
                            let filtered = newValue.filter { $0.isNumber }

                            if filtered.count > 0 { // A digit was entered
                                // Ensure only one character is processed per field
                                self.digits[index] = String(filtered.prefix(1))
                                if index < 3 {
                                    focusedField = OTPField(rawValue: index + 1)
                                } else {
                                    focusedField = nil // Dismiss keyboard if last digit is entered
                                }
                            } else if newValue.isEmpty { // Backspace was pressed
                                // If the current field is empty, move back to the previous one to delete there
                                if self.digits[index].isEmpty && index > 0 {
                                    focusedField = OTPField(rawValue: index - 1)
                                    // Optionally clear the previous digit if moving back to it
                                    // self.digits[index - 1] = ""
                                }
                                self.digits[index] = "" // Clear the current field if it had a digit
                            }
                            // Important: Ensure viewModel.otp is always updated from digits
                            updateOTP()
                        }
                    ))
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .frame(width: 50, height: 50)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .focused($focusedField, equals: OTPField(rawValue: index))
                    // Add a character limit to prevent pasting long strings into one field
                    .onChange(of: digits[index]) { newDigit in
                        if newDigit.count > 1 {
                            digits[index] = String(newDigit.prefix(1))
                            if index < 3 {
                                focusedField = OTPField(rawValue: index + 1)
                            } else {
                                focusedField = nil
                            }
                        }
                    }
                }
            }
            .onAppear { focusedField = .field0 } // Set initial focus to the first field

            // Terms
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

            // Verify Button
            Button(action: {
                Task {
                    let result = await viewModel.verifyOTP()
                    if case .success(let response) = result, response.code == 200 {
                        showShop = true
                        onVerifySuccess?() // Call the success callback if provided
                    }
                }
            }) {
                Text("Verify")
                    .frame(maxWidth: .infinity)
                    .padding()
                    // Use viewModel.otp.count directly as it's kept in sync
                    .background(viewModel.otp.count == 4 ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(viewModel.otp.count != 4 || viewModel.isLoading) // Disable if not 4 digits or loading
            .padding(.horizontal)

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            // Show loading indicator
            if viewModel.isLoading {
                ProgressView()
            }

            Spacer()
        }
        // This onChange is for reacting to the viewModel's API response, not for OTP input
        .onChange(of: viewModel.otpResponse) { response in
            if let response = response, response.code == 200, Constants.API.companySettingsAuthKey != "060fac9a80afec9b95eb292ad884c5f5" {
                showShop = true
                onVerifySuccess?()
            }
        }
        .fullScreenCover(isPresented: $showShop) {
            ShopView()
        }
    }

    // Helper function to update the combined OTP string in the viewModel
    private func updateOTP() {
        viewModel.otp = digits.joined()
        print("Current OTP: \(viewModel.otp)") // For debugging
    }
}
