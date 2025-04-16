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
    
    func fetchData() {
        networkService?.fetchData(from: "https://dummyjson.com/todos") { result in
            switch result {
            case .success(let data): print(data.todos[0].todo)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    func saveString(_ string: String) {
        //Saving
        output?.didRecieveData(data: ["Data saved"])
    }
    
    
}



