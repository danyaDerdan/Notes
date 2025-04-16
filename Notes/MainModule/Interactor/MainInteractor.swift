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
    
    func fetchData() {
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
    
    func saveString(_ string: String) {
        //Saving
        output?.didRecieveData(data: ["Data saved"])
    }
    
    
}



