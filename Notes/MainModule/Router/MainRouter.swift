import UIKit

protocol RouterProtocol {
    func showMainModule()
    func showDetailModule(title: String)
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
    
    func showDetailModule(title: String) {
        navigationController.pushViewController(assembly.createDetailModule(title: title), animated: true)
    }
}
