class IntroSlidesViewModel: ObservableObject {
    @Published var slides: [IntroSlide] = [
        .init(imageName: "intro1", heading: "Welcome", description: "Welcome to WaterCastle!"),
        .init(imageName: "intro2", heading: "Fast Delivery", description: "Get your water delivered fast."),
        .init(imageName: "intro3", heading: "Best Quality", description: "We provide the best quality water."),
        .init(imageName: "intro4", heading: "Easy Payment", description: "Pay easily with multiple options."),
        .init(imageName: "intro5", heading: "Start Shopping", description: "Let’s get started!")
    ]
}