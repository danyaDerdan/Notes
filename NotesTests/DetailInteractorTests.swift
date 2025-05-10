import XCTest
@testable import Notes

class DetailInteractorTests: XCTestCase {
    
    var interactor: DetailInteractor?
    var mockCoreDataManager: MockCoreDataManager?
    
    override func setUp() {
        super.setUp()
        interactor = DetailInteractor()
        mockCoreDataManager = MockCoreDataManager()
        interactor?.coreDataManager = mockCoreDataManager
    }

    
    func testSaveData() {
        mockCoreDataManager?.didCallMethod = false
        
        interactor?.saveData(title: "Test", date: "Test", body: "Test")
        
        XCTAssertTrue(mockCoreDataManager?.didCallMethod ?? false)
    }
    
}
