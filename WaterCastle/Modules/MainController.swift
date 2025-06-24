import SwiftUI

struct MainController: View {
    
    @State var selected = 0
    
    var body: some View {
        ZStack {
            Constants.AppColor.lightGrayColor
                .edgesIgnoringSafeArea(.all)
            TabView(selection: $selected) {
                HomeView()
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
                BagView()
                    .tabItem {
                        Image(systemName: "bag.fill")
                        Text(NSLocalizedString("tab_cart", comment: "Cart"))
                    }.tag(3)
                ProfileView()
                    .tabItem {
                        Image(systemName: "ellipsis.circle.fill")
                        Text(NSLocalizedString("tab_more", comment: "More"))
                    }.tag(4)
            }
        }
        .accentColor(Constants.AppColor.accentTabColor)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainController()
    }
}
