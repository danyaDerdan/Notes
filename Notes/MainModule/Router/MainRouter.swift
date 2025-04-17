import UIKit

protocol RouterProtocol {
    func showMainModule()
    func showDetailModule(title: String, date: String, body: String)
}

final class MainRouter: RouterProtocol {
    var navigationController: UINavigationController
    var assembly: AssemblyProtocol
    
    init(navigationController: UINavigationController, assembly: AssemblyProtocol) {
        self.navigationController = navigationController
        self.assembly = assembly
    }
    
    func showMainModule() {
        navigationController.viewControllers = [assembly.createMainModule()]
    }
    
    func showDetailModule(title: String, date: String, body: String) {
        navigationController.pushViewController(assembly.createDetailModule(title: title, date: date, body: body), animated: true)
    }
}
