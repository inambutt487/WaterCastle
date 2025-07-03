import SwiftUI

struct StartView: View {
    @StateObject private var viewModel = StartViewModel()
    @StateObject private var introVM = IntroSlidesViewModel()
    
    @Environment(\.locale) var locale
    @State private var navigateToMain = false
    @State private var showIntro = false

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
                        navigateToMain = true
                    }) {
                        Text(NSLocalizedString("start", comment: "Start"))
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
                    if !UserDefaults.standard.bool(forKey: "didShowIntro") {
                        showIntro = true
                    } else {
                        Task { await viewModel.fetchCompanySettings() }
                    }
                }
                .background(Constants.AppColor.backgroundColor.ignoresSafeArea())
                .fullScreenCover(isPresented: $showIntro, onDismiss: {
                    UserDefaults.standard.set(true, forKey: "didShowIntro")
                    Task { await viewModel.fetchCompanySettings() }
                }) {
                    IntroSlidesView(viewModel: introVM, isFinished: $showIntro)
                }
                .fullScreenCover(isPresented: $navigateToMain) {
                    MainController()
                }
        
    }

}

#Preview {
    StartView()
}
