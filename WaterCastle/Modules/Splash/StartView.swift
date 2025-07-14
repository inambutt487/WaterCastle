import SwiftUI

struct StartView: View {
    @StateObject private var viewModel = StartViewModel()
    @EnvironmentObject var nav: AppNavigationState
    @Environment(\.locale) var locale

    var body: some View {
        VStack {
            Spacer()
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else if viewModel.showStartButton {
                VStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Button(action: {
                        nav.markStartViewSeen()
                    }) {
                        Text(NSLocalizedString("Start", comment: "Start"))
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Constants.AppColor.primaryBlack)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal, 40)
                    }
                    .transition(.opacity)
                }
            } else {
                Text("No data received from server.")
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .onAppear {
            Task { await viewModel.fetchCompanySettings() }
        }
        .background(Constants.AppColor.backgroundColor.ignoresSafeArea())
    }
}

#Preview {
    StartView()
}
