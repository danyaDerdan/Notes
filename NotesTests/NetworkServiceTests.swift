import XCTest
@testable import Notes

final class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService?
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
    }
    
    func testFetchValidUrl() {
        let stringUrl = "https://dummyjson.com/todos"
        
        networkService?.fetchData(from: stringUrl, completion: { result in
            switch result {
            case .failure(let error): XCTFail("Error: \(error)")
            case .success(_): XCTAssert(true)
            }
        })
        
    }
    
    func testInvalidUrl() {
        let stringUrl = ""
        
        networkService?.fetchData(from: stringUrl, completion: { result in
            switch result {
            case .success(_): XCTFail()
            case .failure(let error): XCTAssert(error.localizedDescription.contains("Notes.NetworkError error 0"))
            }
        })
    }
    
    func testFetchValidData() {
        let stringUrl = "https://dummyjson.com/todos"
        
        networkService?.fetchData(from: stringUrl, completion: { result in
            switch result {
            case .failure(let error): XCTFail("Error: \(error)")
            case .success(let toDo): XCTAssert(toDo.todos.count > 0)
            }
        })
    }
    
}
