import SwiftUI

struct MainController: View {
    @EnvironmentObject var nav: AppNavigationState
    @State private var showLogin: Bool = false

    var body: some View {
        ZStack {
            TabView {
                HomeView(onProductTap: { product, promotions, quantity in
                    if nav.isLoggedIn {
                        nav.selectedProduct = product
                        nav.selectedPromotions = promotions
                        nav.selectedQuantity = quantity
                        nav.showProductDetails = true
                    } else {
                        nav.selectedProduct = product
                        nav.selectedPromotions = promotions
                        nav.selectedQuantity = quantity
                        showLogin = true
                    }
                })
                .tabItem {
                    Image(systemName: "house.fill")
                    Text(NSLocalizedString("tab_home", comment: "Home"))
                }.tag(0)
                Shopping()
                    .tabItem {
                        Image(systemName: "cart.fill")
                        Text(NSLocalizedString("tab_shop", comment: "Shop"))
                    }.tag(1)
                FavoriteView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text(NSLocalizedString("tab_favorite", comment: "Favorite"))
                    }.tag(2)
                if nav.isLoggedIn {
                    ProfileView()
                        .tabItem {
                            Image(systemName: "ellipsis.circle.fill")
                            Text(NSLocalizedString("tab_more", comment: "More"))
                        }.tag(4)
                }
            }
            .fullScreenCover(isPresented: $nav.showProductDetails, onDismiss: {
                nav.showProductDetails = false
                nav.selectedProduct = nil
                nav.selectedPromotions = []
                nav.selectedQuantity = 1
            }) {
                if let _ = nav.selectedProduct {
                    ProductDetailsView()
                        .environmentObject(nav)
                }
            }
            .fullScreenCover(isPresented: $showLogin, onDismiss: {
                // If login is successful, show product details
                if nav.isLoggedIn {
                    nav.showProductDetails = true
                }
            }) {
                LoginView(onLoginSuccess: {
                    nav.isLoggedIn = true
                    showLogin = false
                })
                .environmentObject(nav)
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainController()
            .environmentObject(AppNavigationState())
    }
}
