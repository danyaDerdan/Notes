import XCTest
@testable import Notes

class MainInteractorTests: XCTestCase {
    
    var interactor: MainInteractor?
    var mockCoreDataManager: MockCoreDataManager?
    var mockNetworkService: MockNetworkService?
    
    override func setUp() {
        super.setUp()
        interactor = MainInteractor()
        mockNetworkService = MockNetworkService()
        mockCoreDataManager = MockCoreDataManager()
        interactor?.coreDataManager = mockCoreDataManager
        interactor?.networkService = mockNetworkService
    }
    
    func testNetworkServiceCall() {
        mockNetworkService?.didCallMethod = false
        
        interactor?.fetchData()
        
        XCTAssertTrue(mockNetworkService?.didCallMethod ?? false)
    }
    
    func testSaveDataCall() {
        mockCoreDataManager?.didCallMethod = false
        
        let notes = mockCoreDataManager?.fetchData()
        
        XCTAssert(notes?.count ?? 0 == 0)
        XCTAssertTrue(mockCoreDataManager?.didCallMethod ?? false)
    }
    
    func testDeleteNote() {
        mockCoreDataManager?.didCallMethod = false
        
        mockCoreDataManager?.deleteToDo(title: "Test")
        
        XCTAssertTrue(mockCoreDataManager?.didCallMethod ?? false)
    }
    
    
}

class MockCoreDataManager: CoreDataManagerProtocol {
    
    var didCallMethod = false
    
    func fetchData() -> [Notes.ToDo] {
        didCallMethod = true
        return []
    }
    
    func saveData(title: String, body: String, date: String, isDone: Bool) {
        didCallMethod = true
    }
    
    func deleteToDo(title: String) {
        didCallMethod = true
    }
    
    func toggleToDo(title: String) {
        
    }
    
    func isToDoExist(title: String) -> Bool {
        return false
    }
    
    func updateData(oldTitle: String, newTitle: String, body: String, date: String) {
    }
}

class MockNetworkService: NetworkServiceProtocol {
    
    var didCallMethod = false
    
    func fetchData(from stringUrl: String, completion: @escaping (Result<Notes.ToDoResponse, any Error>) -> Void) {
        didCallMethod = true
    }
}
