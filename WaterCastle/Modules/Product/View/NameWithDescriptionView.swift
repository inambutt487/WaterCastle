struct NameWithDescriptionView: View {
    let name: String?

    var body: some View {
        let parts = name?.splitNameAndDescription() ?? ("", nil)

        VStack(alignment: .leading, spacing: 2) {
            Text(parts.title)
                .font(.headline)

            if let desc = parts.description {
                Text(desc)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
