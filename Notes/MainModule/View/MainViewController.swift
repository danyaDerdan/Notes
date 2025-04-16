import UIKit

protocol MainViewInput {
    var output: MainViewOutput? { get }
    func updateView(with data: [ViewData.Note])
}

protocol MainViewOutput {
    func tappedNote(with text: String)
    func toggledNote(title: String?)
    func viewDidLoad()
}

class MainViewController: UIViewController, MainViewInput {
    var output: MainViewOutput?
    private var tasks: [ViewData.Note] = []
    private lazy var tableView = createTableView()
    
    func updateView(with data: [ViewData.Note]) {
        tasks = data
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        output?.viewDidLoad()
        title = "Заметки"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

private extension MainViewController {
    
    func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        return tableView
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableCell else {
            return UITableViewCell()
        }
        cell.configure(with: tasks[indexPath.row], output: self)
        return cell
    }
}

extension MainViewController: TableCellOutput {
    func didTapButton(in cell: TableCell) {
        output?.toggledNote(title: cell.titleLabel.text)
        tableView.reloadData()
    }
    
    
}
