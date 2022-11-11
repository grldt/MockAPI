//
//  ProductModel.swift
//  MockAPI
//
//  Created by Gerald Stephanus on 10/11/22.
//

import Foundation

struct Product: Codable {
    var ok: Bool
    
    struct DataResponse: Codable, Identifiable {
        var id: String { colorTheme }
        var productName: String
        var productLogo: String
        var description: String
        var rating: Double
        var latestVersion: String
        var publisher: String
        var colorTheme: String
    }
    var data: [DataResponse]
    
    var message: String
    var status: Int
}
