protocol MainViewInput {
    var output: MainViewOutput? { get }
    func updateView(with data: [String])
}

protocol MainViewOutput {
    func tappedNote(with text: String)
}

import UIKit

class MainViewController: UIViewController, MainViewInput {
    var output: MainViewOutput?
    
    func updateView(with data: [String]) {
        print("Updated view with data: \(data)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        output?.tappedNote(with: "Tapped note with text 'viewDidLoad'")
    }
    
    
}

