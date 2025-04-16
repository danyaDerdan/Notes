import UIKit

protocol AssemblyProtocol {
    func createMainModule() -> UIViewController
    func createDetailModule() -> UIViewController
}

final class Assembly: AssemblyProtocol {
    weak var router: RouterProtocol?
    private let networkService = NetworkService()
    
    func createMainModule() -> UIViewController {
        let view = MainViewController()
        let interactor = MainInteractor()
        
        let presenter = MainPresenter(router: router, view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        interactor.networkService = networkService
        
        return view
    }
    
    func createDetailModule() -> UIViewController {
        return UIViewController()
    }
    
    
}
