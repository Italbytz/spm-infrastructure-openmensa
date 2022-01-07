// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let days = try? newJSONDecoder().decode(Days.self, from: jsonData)

import Foundation

// MARK: - Day
public struct Day: Codable {
    let date: String
    let closed: Bool
}

public typealias Days = [Day]
