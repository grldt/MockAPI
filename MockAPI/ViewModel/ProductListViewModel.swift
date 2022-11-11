//
//  ProductListViewModel.swift
//  MockAPI
//
//  Created by Gerald Stephanus on 10/11/22.
//

import Foundation
import SwiftUI

class ProductListViewModel: ObservableObject {
    @Published var products: [Product.DataResponse] = []
    @Published var showFav: Bool = false
    var prodVM = ProductViewModel()
    
    private var apiurl = "https://apimocha.com/telkom/v2/products"
    
    func showFavs() {
        withAnimation {
            showFav.toggle()
        }
    }
    
    var favFilter: [Product.DataResponse] {
        if showFav {
            return products.filter { prodVM.loadFavs().contains($0.id) }
        }
        return products
    }
    
    func fetchProducts() async {
        guard let url = URL(string: apiurl) else {
            print("Missing URL")
            return
        }
        
        do {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Error while fetching data")
                return
            }
            
            if let decodedData = try? JSONDecoder().decode(Product.self, from: data) {
                DispatchQueue.main.async {
                    self.products = decodedData.data
                }
            }
        } catch {
            print("error getting data from API")
        }
    }
}
