import UIKit

protocol AssemblyProtocol {
    func createMainModule() -> UIViewController
    func createDetailModule(title: String, date: String, body: String) -> UIViewController
}

final class Assembly: AssemblyProtocol {
    var router: RouterProtocol?
    private let networkService = NetworkService()
    private let coreDataManager = CoreDataManager()
    
    func createMainModule() -> UIViewController {
        let view = MainViewController()
        let interactor = MainInteractor()
        
        let presenter = MainPresenter(router: router, view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        interactor.networkService = networkService
        interactor.coreDataManager = coreDataManager
        
        return view
    }
    
    func createDetailModule(title: String, date: String, body: String) -> UIViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        
        let presenter = DetailPresenter(view: view, interactor: interactor, router: router)
        
        view.output = presenter
        interactor.output = presenter
        interactor.coreDataManager = coreDataManager
        interactor.title = title
        interactor.date = date
        interactor.body = body
        
        return view

    }
    
    
}
