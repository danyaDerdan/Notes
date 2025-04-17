protocol DetailInteractorInput {
    var output: DetailInteractorOutput? { get set }
    func fetchData()
}

protocol DetailInteractorOutput: AnyObject {
    func dataReceived(title: String, date: String, body: String)
}

final class DetailInteractor: DetailInteractorInput {
    weak var output: DetailInteractorOutput?
    var coreDataManager: CoreDataManager?
    var title: String = ""
    var date: String = ""
    var body: String = ""
    
    func fetchData() {
        output?.dataReceived(title: title, date: date, body: body)
    }
}
