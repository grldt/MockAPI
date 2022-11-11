//
//  MockAPITests.swift
//  MockAPITests
//
//  Created by Gerald Stephanus on 11/11/22.
//

import XCTest
import SwiftUI

final class MockAPITests: XCTestCase {
    private var sut: ProductListViewModel!
    private var sut2: ProductViewModel!
    
    private var favTest: [String] = []
    private var favUD: Set<String> = []
    private var userArray: [String] = []
    
    override func setUpWithError() throws {
        sut = ProductListViewModel()
        //        productModel = Product()
        sut.showFav = true
        favTest = ["B25068", "E7AB79"] //Set myIndiHome and QRen as favorites
        userArray = UserDefaults.standard.array(forKey: "fav") as? [String] ?? [String]()
        
        
        sut2 = ProductViewModel()
        
    }
    
    override func tearDownWithError() throws {
        sut = nil
        UserDefaults.standard.set(userArray, forKey: "fav")
    }
    
    //Testing favorite filter for product list - actual worked but testing failed
    func testFavoriteFilter() async {
        UserDefaults.standard.set(favTest, forKey: "fav")
        
        await sut.fetchProducts()
        
        var actualFavs: [String] = []
        
        let filtered = sut.favFilter
        
        for fav in filtered {
            actualFavs.append(fav.id)
        }
        
        let expectedFavs = ["B25068", "E7AB79"]
        
        XCTAssertEqual(actualFavs, expectedFavs)
    }
    
    //Testing saving favorite from detail view
    func testSaveToFavorites() {
        UserDefaults.standard.set([], forKey: "fav")
        sut2.toggleFavorite(id: "395B64") //Set PeduliLindungi as a favorite
        
        let actual = sut2.checkFav(id: "395B64")
        let expected = true
        
        XCTAssertEqual(actual, expected)
    }
}
