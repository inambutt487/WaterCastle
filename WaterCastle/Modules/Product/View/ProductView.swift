import SwiftUI

struct ProductView: View {
    
    var row: ProductData
    var promotions: [Promotion] = []
    @State var show = false
    @State var quantity: Int = Int(CompanySettingsManager.shared.settings?.minQty ?? "") ?? 1
    var onProductTap: ((ProductData, [Promotion], Int) -> Void)? = nil
    
    fileprivate func TopLabel() -> some View {
        let isNew = row.beforeDiscount == row.price
        return Text(isNew ? "New" : "-")
            .font(.custom(Constants.AppFont.semiBoldFont, size: 13))
            .padding([.trailing, .leading], 8)
            .frame(height: 25)
            .background(isNew ? Constants.AppColor.primaryBlack : Color.init(hex: "DB3022"))
            .cornerRadius(12.5)
            .foregroundColor(.white)
    }
    
    fileprivate func FevoriteButton() -> some View {
        return Button(action: {
            print("Name: \(self.row.nameEn ?? "")")
        }) {
            Image(systemName: "heart")
                .foregroundColor(.gray)
                .frame(width: 30, height: 30)
                .background(Color.white)
        }
        .cornerRadius(20)
        .opacity(0.9)
        .shadow(color: Color.init(hex: "dddddd"), radius: 0.5, x: 0.3, y: 0.3)
    }
    
    var body: some View {
        
        let isPromo = row.isPromoted(using: promotions)
        let matchedPromo = row.matchedPromotion(from: promotions)
        
        ZStack {
            VStack(alignment: .leading, spacing: 5) {
                // Image or Promotion Image
                let promoImages = row.promotionImages(from: promotions)
                if let promoImage = promoImages.first {
                    let promoURL = Constants.API.imageBaseURL + promoImage
                    AsyncImage(url: URL(string: promoURL)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 190)
                    .cornerRadius(5)
                    .overlay(
                        VStack {
                            if isPromo {
                                            Text("PROMOTION")
                                                .font(.headline)
                                                .foregroundColor(.red)

                                            if let info = matchedPromo?.info?.textEn {
                                                Text(info)
                                                    .font(.subheadline)
                                                    .padding(.top, 4)
                                            }

                                            
                                        }

                                        Text(row.nameEn ?? "")
                                        Text("SAR \(row.displayedPrice)")
                            Spacer()
                            FevoriteButton()
                                .padding([.top, .trailing], 5)
                        },
                        alignment: .topTrailing
                    )
                } else if let firstImg = row.img.first {
                    let fullURL = Constants.API.imageBaseURL + firstImg.imagePath
                    AsyncImage(url: URL(string: fullURL)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 190)
                    .cornerRadius(5)
                    .overlay(
                        FevoriteButton()
                            .padding([.top, .trailing], 5),
                        alignment: .topTrailing
                    )
                }

                let nameProduct  =  row.nameEn ?? ""
                // Product Name
                NameWithDescriptionView(name: nameProduct)
                // Price
                Text("SAR \(row.displayedPrice)")
                    .font(.custom(Constants.AppFont.semiBoldFont, size: 13))
                    .foregroundColor(Constants.AppColor.primaryBlack)
                    .padding(.horizontal, 5)

                // Quantity Selector
                HStack(spacing: 10) {
                    Button(action: { if quantity > 1 { quantity -= 1 } }) {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.gray)
                    }
                    TextField("Qty", value: $quantity, formatter: NumberFormatter())
                        .frame(width: 40)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                    Button(action: { quantity += 1 }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 5)

                Spacer()
            }
            .frame(width: 170, height: 285)
            .background(Color.clear)
            .clipped()
            .onTapGesture {
                let selection = CachedProductSelection(product: row, promotions: promotions, quantity: quantity)
                LocalDatabase.saveProductSelection(selection)
                onProductTap?(row, promotions, quantity)
            }
        }
    }

}

struct Product_Previews: PreviewProvider {
    static var previews: some View {
        let sampleProduct = ProductData(
            id: "1",
            img: [
                Img(productGalleryID: 1, productID: 1, imagePath: "https://via.placeholder.com/150", isDefault: 1)
            ],
            bottles: 1,
            catAr: .plastic,
            catEn: .plastic,
            catKw: "Plastic",
            price: "30",
            priceVat: "35",
            beforeDiscount: "40",
            material: "Plastic",
            unit: .car,
            nameAr: "منتج",
            nameEn: "Product",
            nameKw: "منتج",
            descriptionAr: "تفاصيل المنتج",
            descriptionEn: "Product Description",
            descriptionKw: "تفاصيل المنتج",
            productSortApp: "sale",
            categoryID: "123",
            status: "active",
            stock: "100",
            tagsEn: [],
            tagsAr: []
        )

        let mockPromotion = Promotion(
            promotionID: 101,
            title: nil,
            productID: ["1"].compactMap { Int($0) },
            minQuantity: 1,
            addOn: nil,
            cityID: nil,
            startDate: nil,
            endDate: nil,
            imageWebEn: nil,
            imageWebAr: nil,
            imageWebKw: nil,
            imageMobileEn: "https://via.placeholder.com/300x200",
            imageMobileAr: nil,
            imageMobileKw: nil,
            promotionLevel: "product",
            isOffer: 1,
            isFootball: 0,
            link: nil,
            clubIDS: nil,
            enableWithPromo: 1,
            status: 1,
            sort: 0,
            info: Info(
                textEn: "10% OFF",
                textAr: "خصم 10%",
                imageEn: nil,
                imageAr: nil,
                focTitleEn: nil,
                focTitleAr: nil
            ),
            createdAt: nil,
            rangeLimit: nil,
            channelID: nil,
            groupID: nil,
            promotionType: nil,
            onProducts: nil,
            locations: nil,
            giftProducts: nil,
            webImage: nil,
            mobileImage: nil,
            updatedAt: nil,
            countryID: nil,
            multiFoc: nil,
            isBanner: 0,
            isDonation: 0,
            quantity: 1,
            infoEn: nil,
            infoAr: nil,
            infoKw: nil,
            focProd: nil,
            focItems: nil,
            emptyFoc: nil
        )

        return ProductView(row: sampleProduct, promotions: [mockPromotion])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

