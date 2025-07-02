final class UserManager: ObservableObject {
    static let shared = UserManager()
    @Published var user: User? = LocalDatabase.loadUser()
    private init() {}
}
