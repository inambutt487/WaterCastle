import SwiftUI

struct SettingsView: View {
    let settings: CompanySettingData?
    
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
                        Text("Minimum Quantity")
                        Spacer()
                        Text(settings.minQty)
                    }

                    HStack {
                        Text("VAT")
                        Spacer()
                        Text(settings.vat)
                    }

                    HStack {
                        Text("Helpline")
                        Spacer()
                        Text(settings.helpLine)
                    }

                    HStack {
                        Text("Android Version")
                        Spacer()
                        Text(settings.curAndroidVer)
                    }

                    HStack {
                        Text("iOS Version")
                        Spacer()
                        Text(settings.curIosVer)
                    }

                    HStack {
                        Text("WhatsApp")
                        Spacer()
                        Text(settings.whatsApp)
                    }

                    HStack {
                        Text("Enable Ticket")
                        Spacer()
                        Text(settings.isTicketEnable)
                    }

                    HStack {
                        Text("Show VAT")
                        Spacer()
                        Text(settings.showVat)
                    }

                    HStack {
                        Text("Change Password Msg (EN)")
                        Spacer()
                        Text(settings.changePasswordMessageEn)
                    }

                    HStack {
                        Text("Currency")
                        Spacer()
                        Text(settings.currency)
                    }

                    HStack {
                        Text("Country Code")
                        Spacer()
                        Text(settings.countryCode)
                    }

                    HStack {
                        Text("Email")
                        Spacer()
                        Text(settings.email)
                    }

                    HStack {
                        Text("Force Change Password")
                        Spacer()
                        Text("\(settings.forceChangePassword)")
                    }

                    HStack {
                        Text("Enable Loyalty Program")
                        Spacer()
                        Text(settings.isLoyaltyProgramEnabled)
                    }

                    HStack {
                        Text("Is Favourite Player Enabled")
                        Spacer()
                        Text(settings.isFavouritePlayerEnabled)
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
    SettingsView(settings: nil)
} 
