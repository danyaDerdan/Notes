import Foundation

protocol MainInteractorInput {
    var output: MainInteractorOutput? { get set}
    func fetchData()
    func toggleNoteWith(title: String)
    func getCurrentDate() -> String
}

protocol MainInteractorOutput: AnyObject {
    func didRecieveData(data: [ViewData.Note])

}

final class MainInteractor: MainInteractorInput {
    weak var output: MainInteractorOutput?
    var networkService: NetworkService?
    var coreDataManager: CoreDataManager?
    
    func fetchData() {
        let savedNotes = coreDataManager?.fetchData() ?? []
        if savedNotes.isEmpty {
            getDataFromNetwork()
        } else {
            output?.didRecieveData(data: getNotes(from: savedNotes.reversed()))
        }
    }
    
    func toggleNoteWith(title: String) {
        coreDataManager?.toggleToDo(title: title)
        fetchData()
    }
    
    private func getDataFromNetwork() {
        networkService?.fetchData(from: "https://dummyjson.com/todos") { result in
            switch result {
            case .failure(let error): print(error.localizedDescription)
            case .success(let data):
                DispatchQueue.main.async {
                    for toDo in data.todos {
                        self.coreDataManager?.saveData(title: toDo.todo,
                                                       body: "\n\n",
                                                       date: self.getCurrentDate(),
                                                       isDone: false)
                    }
                    self.fetchData()
                }
            }
        }
    }
    
    func getCurrentDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let formattedDate = formatter.string(from: Date())
        return formattedDate
    }
    
    private func getNotes(from data: [ToDo]) -> [ViewData.Note] {
        var notes = [ViewData.Note]()
        for note in data {
            notes.append(ViewData.Note(title: note.title ?? "",
                                       body: note.body ?? "",
                                       date: note.date ?? "",
                                       isDone: note.isDone))
        }
        return notes
    }
    
}



