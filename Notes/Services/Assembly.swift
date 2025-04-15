import UIKit

protocol AssemblyProtocol {
    func createMainModule() -> UIViewController
    func createDetailModule() -> UIViewController
}

final class Assembly: AssemblyProtocol {
    func createMainModule() -> UIViewController {
        return UIViewController()
    }
    
    func createDetailModule() -> UIViewController {
        return UIViewController()
    }
    
    
}
