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
    
    func fetchData() {
        output?.didRecieveData(data: ["1", "2", "3", "4", "5"])
    }
    
    func saveString(_ string: String) {
        //Saving
        output?.didRecieveData(data: ["Data saved"])
    }
    
    
}



