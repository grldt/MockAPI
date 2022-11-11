//
//  MainListView.swift
//  MockAPI
//
//  Created by Gerald Stephanus on 10/11/22.
//

import SwiftUI

struct ProductListView: View {
    @StateObject var prodListVM = ProductListViewModel()
    @StateObject var prodVM = ProductViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    Text("Products")
                        .font(.title)
                    Spacer()
                    Button(action: {
                        prodListVM.showFavs()
                    }) {
                        prodListVM.showFav ? Text("Show All") : Text("Show Favorites")
                    }
                    .foregroundColor(Color(UIColor.systemBackground).isDarkColor ? .white : .black)
                }
                .padding(16)
                
                ScrollView {
                    if(prodListVM.products.isEmpty) {
                        ProgressView()
                    }
                    ForEach(prodListVM.favFilter) { prod in
                        ProductView(product: prod)
                    }
                    if(prodListVM.favFilter.isEmpty && prodListVM.showFav) {
                        Text("You don't have any favorite products.")
                    }
                }
            }
            .onAppear(perform: {
                Task {
                    await prodListVM.fetchProducts()
                }
            })
        }
        .accentColor(Color(UIColor.systemBackground).isDarkColor ? .black : .white)
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
