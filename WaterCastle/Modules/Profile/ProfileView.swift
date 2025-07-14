import SwiftUI
import Combine

struct ProfileView: View {
    
    @State var selection: Int? = nil
    let arrProfile = ProfileModel.all()
    @State private var isAddressSheetPresented = false
    @State private var addressList: [Address] = LocalDatabase.loadAddresses() ?? []
    @State private var selectedAddress: Address? = LocalDatabase.loadHomeAddress()
    @State private var didLogout = false
    @EnvironmentObject var nav: AppNavigationState
    @State private var showSettings = false

    fileprivate func NavigationBarView() -> some View {
        return HStack {
            Text("")
        }
        .frame(width: UIScreen.main.bounds.width, height: 45)
        .overlay(
            Text("More")
                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
                .padding(.horizontal, 10)
            , alignment: .center)
    }
    
    var body: some View {
        VStack(spacing: 0) {
        NavigationView {
            VStack(alignment: .leading) {
                NavigationBarView()
                HStack {
                    Image("banner2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(.leading, 15)
                    VStack(alignment: .leading) {
                            let user = UserManager.shared.user
                            let name = (user?.first_name ?? user?.frist_name ?? "") + " " + (user?.last_name ?? "")
                            Text(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Your Name" : name)
                            .font(.headline)
                            .bold()
                            Text(user?.email ?? "youremail@gmail.com")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }.padding(.horizontal, 5)
                    Spacer()
                }.padding(.vertical, 10)
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 10) {
                        ForEach(self.arrProfile, id: \ .id) { profile in
                            if profile.title == "Store Settings" {
                                Button(action: {
                                    showSettings = true
                                }) {
                                    ProfileRow(profile: profile)
                                }
                            } else {
                                ProfileRow(profile: profile)
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                })
                
                Spacer()
                    // User Home Address Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Home Address")
                            .font(.headline)
                        if let address = selectedAddress {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(address.add_name ?? "-")
                                    .font(.subheadline)
                                Text(address.add_detail ?? "-")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        } else {
                            Text("No home address set.")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        HStack {
                            Button(action: {
                                addressList = LocalDatabase.loadAddresses() ?? []
                                isAddressSheetPresented = true
                            }) {
                                Text("Change Address")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            Spacer()
                            Button(action: {
                                // Placeholder for Add New Address feature
                            }) {
                                Text("Add New Address")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .sheet(isPresented: $isAddressSheetPresented) {
                        VStack(alignment: .leading) {
                            Text("Select Address")
                                .font(.headline)
                                .padding()
                            Divider()
                            ScrollView {
                                VStack(alignment: .leading) {
                                    ForEach(addressList, id: \ .add_id) { address in
                                        Button(action: {
                                            selectedAddress = address
                                            LocalDatabase.saveHomeAddress(address)
                                            isAddressSheetPresented = false
                                        }) {
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text(address.add_name ?? "-")
                                                    .font(.subheadline)
                                                Text(address.add_detail ?? "-")
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            }
                                            .padding()
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .background(address.add_id == selectedAddress?.add_id ? Color.blue.opacity(0.15) : Color.gray.opacity(0.1))
                                            .cornerRadius(8)
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                            Spacer()
                            Button("Close") {
                                isAddressSheetPresented = false
                            }
                            .padding()
                        }
                    }
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
                .background(
                    NavigationLink(destination: MainController().navigationBarHidden(true), isActive: $didLogout) { EmptyView() }
                        .hidden()
                )
            }
            Spacer()
            Button(action: {
                // Clear user and addresses from LocalDatabase and UserManager
                UserManager.shared.user = nil
                UserManager.shared.companySettingsAuthKey = "060fac9a80afec9b95eb292ad884c5f5"
                UserDefaults.standard.removeObject(forKey: LocalDatabase.userKey)
                UserDefaults.standard.removeObject(forKey: LocalDatabase.addressesKey)
                UserDefaults.standard.removeObject(forKey: LocalDatabase.homeAddressKey)
                selectedAddress = nil
                addressList = []
                didLogout = true
                nav.resetToLogin()
            }) {
                Text("Logout")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 20)
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AppNavigationState())
    }
}

struct ProfileRow: View {
    
    let profile: ProfileModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(5)
                .shadow(color: Constants.AppColor.shadowColor, radius: 1, x: 0.8, y: 0.8)
            VStack(alignment: .leading) {
                Text(profile.title)
                    .font(.subheadline)
                    .bold()
                    .padding(.bottom, 1)
                Text(profile.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(15)
            Spacer()
        }
    }
}
