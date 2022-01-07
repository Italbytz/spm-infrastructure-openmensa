import Foundation

enum FetchError: Error {
    case statusCodeMissing
    case statusCodeNotOk
    case noMealsForDate
    case mensaClosed
}

public class OpenMensaAPI {
    let url = URL(string: "https://openmensa.org/api/v2")!
    let session = URLSession(configuration: .default)
    public static let dateFormat = "yyyy-MM-dd"
    
    public init() {
        
    }
    
    public func getCanteens() async throws -> Canteens {
        let request = URLRequest(url: url.appendingPathComponent("canteens"))
        let (data, response) = try await session.data(for: request)
        return try self.processResponse(data: data, response: response)
    }
    
    public func getDays(for canteen: Int) async throws -> Days {
        let request = URLRequest(url: url.appendingPathComponent("canteens")
                                    .appendingPathComponent("\(canteen)")
                                    .appendingPathComponent("days"))
        let (data, response) = try await session.data(for: request)
        return try self.processResponse(data: data, response: response)
    }
    
    public func getMeals(for canteen: Int, on date: Date) async throws -> Meals {
        let days = try await getDays(for: canteen)
        let formatter = DateFormatter()
        formatter.dateFormat = OpenMensaAPI.dateFormat
        let requestedDate = formatter.string(from: date)
        for day in days {
            if (day.date == requestedDate) {
                if (day.closed) {
                    throw FetchError.mensaClosed
                }
                let request = URLRequest(url: url.appendingPathComponent("canteens")
                                            .appendingPathComponent("\(canteen)")
                                            .appendingPathComponent("days")
                                            .appendingPathComponent(requestedDate)
                                            .appendingPathComponent("meals"))
                let (data, response) = try await session.data(for: request)
                return try self.processResponse(data: data, response: response)
            }
        }
        throw FetchError.noMealsForDate
    }
    
    public func getTodaysMeals(for canteen: Int) async throws -> Meals {
        return try await getMeals(for: canteen, on: Date())
    }
    
    func processResponse<Value : Decodable>(data: Data, response: URLResponse)
    throws -> Value {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw FetchError.statusCodeMissing
        }
        guard statusCode >= 200 && statusCode < 300 else {
            throw FetchError.statusCodeNotOk
            
        }
        let decoder = JSONDecoder()
        return try decoder.decode(Value.self, from: data)
    }
}
