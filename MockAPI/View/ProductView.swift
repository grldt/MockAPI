//
//  ProductView.swift
//  MockAPI
//
//  Created by Gerald Stephanus on 10/11/22.
//

import SwiftUI

struct ProductView: View {
    @StateObject var prodVM = ProductViewModel()
    @State var product: Product.DataResponse
    @State var isFav: Bool = false
    @State var openProduct: Bool = false
    
    init(product: Product.DataResponse) {
        self.product = product
    }
    
    var body: some View {
        
        Button (action: {
            openProduct.toggle()
        }) {
            HStack {
                AsyncImage(
                    url: URL(string: product.productLogo),
                    content: { image in
                        image.resizable()
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                .frame(width: 72, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(product.productName)
                    .font(.title2)
                    .lineLimit(1)
                
                Spacer()
                
                NavigationLink(destination: ProductDetailView(product: product), isActive: $openProduct) {
                    EmptyView()
                }
                .isDetailLink(false)
                .hidden()
            }
        }
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color(hex: product.colorTheme)))
        .padding(.init(top: 4, leading: 16, bottom: 4, trailing: 16))
        .foregroundColor(Color(hex: product.colorTheme).isDarkColor ? .white : .black)
        .onAppear() {
            isFav = prodVM.checkFav(id: product.colorTheme)
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: Product.DataResponse(
            productName: "Product Test",
            productLogo: "https://i.ibb.co/1sCp7MV/myindihome.png",
            description: "Aplikasi myIndiHome memberi Anda kemudahan dan kenyamanan untuk mengelola layanan IndiHome Anda tanpa harus keluar rumah, terlebih di saat harus #DiRumahAja, di antaranya:\n\n▪︎ Mengecek ketersediaan layanan IndiHome di lokasi yang diinginkan.\n▪︎ Registrasi layanan IndiHome, dan memantau progres pemasangan IndiHome Anda.\n▪︎ Mendapatkan kemudahan untuk menambah layanan seperti Wifi.id Seamless, Upgrade Speed, Speed on Demand, Catchplay+, Iflix, Minipack TV Channels, dan sebagainya.\n▪︎ Mengecek dan melakukan pembayaran tagihan IndiHome.\n▪︎ Mendapatkan info dan promo IndiHome.\n▪︎ Memperoleh dan menukarkan Poin myIndiHome dengan penawaran-penawaran menarik.\n▪︎ Melakukan pengaduan, dan memantau proges penyelesaian pengaduan.\n\nJaga diri dan keluarga Anda, tidak perlu ke mana-mana, cukup gunakan myIndiHome untuk kebutuhan IndiHome Anda.",
            rating: 3.1,
            latestVersion: "4.2.0",
            publisher: "PT. Telkom Indonesia, Tbk.",
            colorTheme: "B25068"))
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    var isDarkColor : Bool {
        return UIColor(self).isDarkColor
    }
}

extension UIColor
{
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.50
    }
}
