//
//  ProductDetailView.swift
//  MockAPI
//
//  Created by Gerald Stephanus on 11/11/22.
//

import SwiftUI

struct ProductDetailView: View {
    @StateObject var prodVM = ProductViewModel()
    
    @State var productLogo: String
    @State var productName: String
    @State var desc: String
    @State var rating: Double
    @State var latestVersion: String
    @State var publisher: String
    @State var colorTheme: String
    @State var isFav: Bool = false
    
    init(product: Product.DataResponse) {
        self.productLogo = product.productLogo
        self.productName = product.productName
        self.desc = product.description
        self.rating = product.rating
        self.latestVersion = product.latestVersion
        self.publisher = product.publisher
        self.colorTheme = product.colorTheme
    }
    
    var body: some View {
        Color(hex: colorTheme)
            .ignoresSafeArea()
            .overlay(
                VStack {
                    HStack {
                        AsyncImage(
                            url: URL(string: productLogo),
                            content: { image in
                                image.resizable()
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                        .frame(width: 128, height: 128)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.trailing, 8)
                        
                        Spacer()
                        
                        VStack {
                            Text(productName)
                                .font(.title2)
                                .bold()
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(publisher)
                                .font(.subheadline)
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 1)
                            
                            HStack {
                                Text(String(rating))
                                    .font(.headline)
                                    .frame(alignment: .leading)
                                
                                ForEach(0..<Int(floor(rating)), id: \.self) { idx in
                                    Image(systemName: "star.fill")
                                }
                                
                                if (rating - floor(rating) >= 0.5) {
                                    Image(systemName: "star.leadinghalf.fill")
                                }
                                
                                ForEach(0..<Int(5 - round(rating)), id: \.self) { idx in
                                    Image(systemName: "star")
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 1)
                            
                            Spacer()
                            
                            Text("Latest Version: \(latestVersion)")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                        }
                    }
                    .frame(height: 128)
                    .padding(.leading, 16)
                    .padding(.bottom, 24)
                    
                    
                    ScrollView {
                        VStack {
                            Text("Description")
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                                .padding(.bottom, 4)
                            
                            Text(desc)
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                    }
                }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                prodVM.toggleFavorite(id: colorTheme)
                                isFav = prodVM.checkFav(id: colorTheme)
                            } label: {
                                if(isFav) {
                                    Image(systemName: "bookmark.fill")
                                } else {
                                    Image(systemName: "bookmark")
                                }
                            }
                        }
                    }
                    .foregroundColor(Color(hex: colorTheme).isDarkColor ? .white : .black)
                    .onAppear() {
                        isFav = prodVM.checkFav(id: colorTheme)
                    }
            )
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product.DataResponse(
            productName: "PeduliLindungi",
            productLogo: "https://i.ibb.co/1sCp7MV/myindihome.png",
            description: "Aplikasi myIndiHome memberi Anda kemudahan dan kenyamanan untuk mengelola layanan IndiHome Anda tanpa harus keluar rumah, terlebih di saat harus #DiRumahAja, di antaranya:\n\n▪︎ Mengecek ketersediaan layanan IndiHome di lokasi yang diinginkan.\n▪︎ Registrasi layanan IndiHome, dan memantau progres pemasangan IndiHome Anda.\n▪︎ Mendapatkan kemudahan untuk menambah layanan seperti Wifi.id Seamless, Upgrade Speed, Speed on Demand, Catchplay+, Iflix, Minipack TV Channels, dan sebagainya.\n▪︎ Mengecek dan melakukan pembayaran tagihan IndiHome.\n▪︎ Mendapatkan info dan promo IndiHome.\n▪︎ Memperoleh dan menukarkan Poin myIndiHome dengan penawaran-penawaran menarik.\n▪︎ Melakukan pengaduan, dan memantau proges penyelesaian pengaduan.\n\nJaga diri dan keluarga Anda, tidak perlu ke mana-mana, cukup gunakan myIndiHome untuk kebutuhan IndiHome Anda.",
            rating: 4.9,
            latestVersion: "4.2.0",
            publisher: "PT. Telkom Indonesia, Tbk.",
            colorTheme: "B25068"))
    }
}
