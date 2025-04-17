import UIKit

protocol DetailViewInput: AnyObject {
    var output: DetailViewOutput? { get set }
    func updateData(title: String, date: String, body: String)
}

protocol DetailViewOutput: AnyObject {
    func viewDidLoad()
    func didTapBackButton(title: String)
}

class DetailViewController: UIViewController, DetailViewInput {
    private lazy var titleField = createTitleField()
    private lazy var dateLabel = createDateLabel()
    private lazy var body = createBody()

    var output: DetailViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        output?.viewDidLoad()
        body.isHidden = false
    }
    
    func updateData(title: String, date: String, body: String) {
        titleField.text = title
        dateLabel.text = date
        self.body.text = body
    }
}

private extension DetailViewController {
    func createTitleField() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        textField.placeholder = "Заголовок"
        textField.font = .systemFont(ofSize: 30, weight: .bold)
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            textField.heightAnchor.constraint(equalToConstant: 50)
            ])
        return textField
    }
    
    func createDateLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            label.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 10)
            ])
        return label
    }
    
    func createBody() -> UITextView {
        let body = UITextView()
        body.font = .systemFont(ofSize: 20, weight: .medium)
        view.addSubview(body)
        body.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            body.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            body.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            body.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            body.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        return body
    }
}
