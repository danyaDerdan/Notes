import Foundation

protocol MainInteractorInput {
    var output: MainInteractorOutput? { get set}
    func fetchData()
    func saveString(_ string: String)
}

protocol MainInteractorOutput: AnyObject {
    func didRecieveData(data: [String])
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
            output?.didRecieveData(data: savedNotes.map {$0.body ?? "" })
        }
    }
    
    func saveString(_ string: String) {
        //Saving
        output?.didRecieveData(data: ["Data saved"])
    }
    
    private func getDataFromNetwork() {
        networkService?.fetchData(from: "https://dummyjson.com/todos") { result in
            switch result {
            case .failure(let error): print(error.localizedDescription)
            case .success(let data):
                DispatchQueue.main.async {
                    self.output?.didRecieveData(data: data.todos.map {$0.todo})
                }
            
            }
        }
    }
    
}



