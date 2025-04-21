protocol DetailInteractorInput {
    var output: DetailInteractorOutput? { get set }
    func fetchData()
    func saveData(title: String, date: String, body: String)
}

protocol DetailInteractorOutput: AnyObject {
    func dataReceived(title: String, date: String, body: String)
    func invalidTitleRecieved(recievedTitle: String, fixedTitle: String) 
}

final class DetailInteractor: DetailInteractorInput {
    weak var output: DetailInteractorOutput?
    var coreDataManager: CoreDataManagerProtocol?
    var title: String = ""
    var date: String = ""
    var body: String = ""
    
    func fetchData() {
        output?.dataReceived(title: title, date: date, body: body)
    }
    
    func saveData(title: String, date: String, body: String) {
        guard !title.isEmpty, title == self.title || checkUniqTitle(title) else {
            notifyInvalidData(title: title)
            return }
        coreDataManager?.updateData(oldTitle: self.title, newTitle: title, body: body, date: date)
        if self.title == "" {
            coreDataManager?.saveData(title: title, body: body, date: date, isDone: false)
        }
    }
    
    private func checkUniqTitle(_ title: String) -> Bool {
        !(coreDataManager?.isToDoExist(title: title) ?? false)
    }
    
    private func notifyInvalidData(title: String) {
        output?.invalidTitleRecieved(recievedTitle: title, fixedTitle: title+"1")
    }
}
