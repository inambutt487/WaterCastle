
import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject var nav: AppNavigationState

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            Image("logo") // Make sure logo.png is in Assets.xcassets
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        }
        .onAppear {
            // Simulate loading or do your startup logic here
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    nav.showSplash = false
                }
            }
        }
    }
}
