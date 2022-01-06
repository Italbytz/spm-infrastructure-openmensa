import XCTest
@testable import OpenMensaInfrastructure

final class OpenMensaInfrastructureTests: XCTestCase {
    
    var api = OpenMensaAPI()
    
    func testGetCanteens() async throws {
        let response = try await api.getCanteens()
        XCTAssert(response.count > 0)        
    }
    
    func testGetDays() async throws {
        let response = try await api.getDays(for: 1)
        XCTAssert(response.count > 0)
    }
    
    func testGetTodaysMeals() async throws {
        do {
            let response = try await api.getTodaysMeals(for: 1)
            XCTAssert(response.count > 0)
        } catch FetchError.noMealsForDate {
            
        } catch FetchError.mensaClosed {
            
        }
    }
}
