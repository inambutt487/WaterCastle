import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @Environment(\.presentationMode) var presentationMode
    var onLoginSuccess: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 24) {
            // Logo
            Image("logo")
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
                        viewModel.phone = String(newValue.prefix(13)).filter { "0123456789".contains($0) }
                    }
            }
            .padding(.horizontal)
            
            // Login Button
            Button(action: {
                Task { await viewModel.login(skKey: "your_sk_key") }
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.phone.count >= 9 && viewModel.phone.count <= 13 ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(viewModel.phone.count < 9 || viewModel.phone.count > 13)
            .padding(.horizontal)
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
            
            Spacer()
        }
        .fullScreenCover(isPresented: $viewModel.showOTP) {
            OTPView(viewModel: viewModel, onVerifySuccess: onLoginSuccess)
        }
    }
}