import UIKit

protocol RouterProtocol: AnyObject {
    func showMainModule()
    func showDetailModule()
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
    
    func showDetailModule() {
        navigationController.pushViewController(assembly.createDetailModule(), animated: true)
    }
}
