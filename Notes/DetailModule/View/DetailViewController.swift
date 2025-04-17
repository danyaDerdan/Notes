import UIKit

protocol DetailViewInput: AnyObject {
    var output: DetailViewOutput? { get set }
}

protocol DetailViewOutput: AnyObject {
    func viewDidLoad()
    func didTapBackButton(title: String)
}

class DetailViewController: UIViewController, DetailViewInput {

    var output: DetailViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        output?.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}
