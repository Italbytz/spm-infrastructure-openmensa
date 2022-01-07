// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let canteens = try? newJSONDecoder().decode(Canteens.self, from: jsonData)

import Foundation

// MARK: - Canteen
public struct Canteen: Codable {
    let id: Int
    let name, city: String
    let address: String
    let coordinates: [Double]?
}

public typealias Canteens = [Canteen]
