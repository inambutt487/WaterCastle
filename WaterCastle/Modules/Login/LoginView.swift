
import SwiftUI

// Assuming all your other structs and classes (APIService, UserManager, Constants, LoginViewModel)
// are correctly defined as provided in previous responses.

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode
    var onLoginSuccess: (() -> Void)?

    @State private var showOTPView = false // Renamed for clarity, though viewModel.showOTP is the source

    var body: some View {
        VStack(spacing: 24) {
            // Logo
            Image("logo") // Make sure "logo" asset exists
                .resizable()
                .frame(width: 120, height: 120)
                .padding(.top, 40)

            // Login Label
            Text("Login")
                .font(.largeTitle)
                .bold()

            // Back Button
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding(.horizontal)

            // Phone Input
            HStack {
                Text("+966")
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                TextField("Phone Number", text: $viewModel.phone)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .onChange(of: viewModel.phone) { newValue in
                        // Keep filtering and limiting here
                        viewModel.phone = String(newValue.prefix(13)).filter { "0123456789".contains($0) }
                    }
            }
            .padding(.horizontal)

            // Login Button
            Button(action: {
                Task {
                    let result = await viewModel.login(skKey: "your_sk_key")
                    if case .success(let response) = result, response.code == 200 {
                        // This will trigger the fullScreenCover based on viewModel.showOTP
                        // which is set to true in LoginViewModel's login method upon success.
                        // You can also explicitly set a local @State here if you prefer,
                        // but using viewModel.showOTP is fine.
                        // For example: self.showOTPView = true
                    }
                }
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.phone.count >= 9 && viewModel.phone.count <= 13 ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(viewModel.phone.count < 9 || viewModel.phone.count > 13 || viewModel.isLoading) // Disable if phone invalid or loading
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
        // This is the correct way to present OTPView based on viewModel.showOTP
        .fullScreenCover(isPresented: $viewModel.showOTP) {
            OTPView(viewModel: viewModel, onVerifySuccess: {
                onLoginSuccess?() // Propagate success if OTP verification passes
                // You might want to dismiss the OTPView here if onLoginSuccess()
                // handles the full flow and goes to another view.
                // presentationMode.wrappedValue.dismiss() // If OTPView should be dismissed after success
            })
        }
    }
}
