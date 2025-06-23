
import SwiftUI

struct StartView: View {
    @State private var isLoading = true
    @State private var showStartButton = false
    @State private var errorMessage: String?
    @Environment(\.locale) var locale

    var body: some View {
        VStack {
            Spacer()
            if isLoading {
                ProgressView()
                    .onAppear(perform: fetchCompanySettings)
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else if showStartButton {
                VStack() {
                    Image("logo") // Make sure logo.png is in Assets.xcassets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Button(action: {
                        // Proceed to main app
                        MainController()
                    }) {
                        Text(NSLocalizedString("start", comment: "Start"))
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal, 40)
                    }
                    .transition(.opacity)
                }
            }
            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
    }

    private func fetchCompanySettings() {
        guard let url = URL(string: "https://fgstg.berain.com.sa/berain_oms/api/v4/companysetting") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("060fac9a80afec9b95eb292ad884c5f5", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = [
            "location_date": "2025-05-01",
            "country_id": "2229"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                if let data = data,
                   let decoded = try? JSONDecoder().decode(CompanySettingsResponse.self, from: data) {
                    // Save to singleton and local database
                    CompanySettingsManager.shared.settings = decoded.rows
                    LocalDatabase.saveCompanySettings(decoded.rows)
                    showStartButton = true
                } else {
                    errorMessage = NSLocalizedString("error_generic", comment: "Something went wrong. Please try again.")
                }
            }
        }.resume()
    }
}

#Preview {
    StartView()
}
