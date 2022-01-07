// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let meals = try? newJSONDecoder().decode(Meals.self, from: jsonData)

import Foundation

// MARK: - Meal
public struct Meal: Codable {
    let id: Int
    let name, category: String
    let prices: Prices
    let notes: [String]
}

// MARK: - Prices
public struct Prices: Codable {
    let students, employees: Double?
    let pupils: Double?
    let others: Double?
}

public typealias Meals = [Meal]

