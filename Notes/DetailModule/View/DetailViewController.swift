import UIKit

protocol DetailViewInput {
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
}
