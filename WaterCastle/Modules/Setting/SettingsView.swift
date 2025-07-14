import SwiftUI

struct SettingsView: View {
    var settings: CompanySettingData? {
        CompanySettingsManager.shared.settings
    }
    
    var body: some View {
        Form {
            if let settings = settings {
                Section(header: Text("Store Settings")) {
                    HStack {
                        Text("Minimum Order")
                        Spacer()
                        Text(settings.minOrder)
                    }

                    HStack {
                        Text("Helpline")
                        Spacer()
                        Text(settings.helpLine)
                    }

                    HStack {
                        Text("iOS Version")
                        Spacer()
                        Text(settings.curIosVer)
                    }

                    HStack {
                        Text("Show VAT")
                        Spacer()
                        Text(settings.showVat == "1" ? "Yes" : "No")
                    }

                    HStack {
                        Text("Currency")
                        Spacer()
                        Text(settings.currency)
                    }

                    HStack {
                        Text("Email")
                        Spacer()
                        Text(settings.email)
                    }
                }
            } else {
                Text("No settings available.")
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    SettingsView()
} 
