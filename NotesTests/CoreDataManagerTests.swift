import CoreData
import XCTest
@testable import Notes

final class CoreDataManagerTests: XCTestCase {

    var coreDataManager: CoreDataManager?
        
    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager()
    }
    
    func testSaveAndFetchNote() {
        let note = ViewData.Note(title: "Test", body: "", date: "", isDone: false)
        
        coreDataManager?.saveData(title: note.title, body: note.body, date: note.date, isDone: note.isDone)
        let fetchedNotes = coreDataManager?.fetchData() ?? []
        
        XCTAssertEqual(fetchedNotes.last?.title, "Test")
    }
    
    func testSaveAndDeleteNote() {
        let note = ViewData.Note(title: "Test", body: "", date: "", isDone: false)
        
        coreDataManager?.saveData(title: note.title, body: note.body, date: note.date, isDone: note.isDone)
        let noteCountBeforeDelete = coreDataManager?.fetchData().count ?? 0
        coreDataManager?.deleteToDo(title: note.title)
        let noteCountAfterDelete = coreDataManager?.fetchData().count ?? 0
        
        XCTAssertEqual(noteCountAfterDelete, noteCountBeforeDelete - 1)
    }
}

