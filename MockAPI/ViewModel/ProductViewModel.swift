//
//  ProductViewModel.swift
//  MockAPI
//
//  Created by Gerald Stephanus on 11/11/22.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    func toggleFavorite(id: String) {
        var favs = loadFavs()
        if(favs.contains(id)) {
            favs.remove(id)
        } else {
            favs.insert(id)
        }
        saveFavs(favs: favs)
    }
    
    func checkFav(id: String) -> Bool {
        return loadFavs().contains(id)
    }
    
    func loadFavs() -> Set<String> {
        let array = UserDefaults.standard.array(forKey: "fav") as? [String] ?? [String]()
        print(array)
        return Set(array)
    }
    
    func saveFavs(favs: Set<String>) {
        let array = Array(favs)
        UserDefaults.standard.set(array, forKey: "fav")
    }
}
