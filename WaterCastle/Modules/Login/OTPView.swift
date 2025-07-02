import SwiftUI

struct OTPView: View {
    @ObservedObject var viewModel: LoginViewModel
    @Environment(\.presentationMode) var presentationMode
    var onVerifySuccess: (() -> Void)?
    
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
            
            // OTP Input
            TextField("OTP", text: $viewModel.otp)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .frame(width: 100)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .onChange(of: viewModel.otp) { newValue in
                    viewModel.otp = String(newValue.prefix(4)).filter { "0123456789".contains($0) }
                }
            
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
                Task { await viewModel.verifyOTP() }
            }) {
                Text("Verify")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.otp.count == 4 ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(viewModel.otp.count != 4)
            .padding(.horizontal)
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
            
            Spacer()
        }
        .onChange(of: viewModel.otpResponse) { response in
            if let response = response, response.code == 200 {
                onVerifySuccess?()
            }
        }
    }
}