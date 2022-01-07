// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let meals = try? newJSONDecoder().decode(Meals.self, from: jsonData)

import Foundation

// MARK: - Meal
public struct Meal: Codable {
    public let id: Int
    public let name, category: String
    public let prices: Prices
    public let notes: [String]
}

// MARK: - Prices
public struct Prices: Codable {
    public let students, employees, pupils, others: Double?
}

public typealias Meals = [Meal]

