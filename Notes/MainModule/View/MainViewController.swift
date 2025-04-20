import UIKit

protocol MainViewInput: AnyObject {
    var output: MainViewOutput? { get }
    func updateView(with data: [ViewData.Note])
}

protocol MainViewOutput {
    func tappedNote(title: String?, date: String?, body: String?)
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
        setupPanel()
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        return tableView
    }
    
    func setupPanel() {
        let panel = UIView()
        panel.backgroundColor = .systemGray6
        view.addSubview(panel)
        panel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            panel.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            panel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            panel.widthAnchor.constraint(equalTo: view.widthAnchor),
            panel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let button = UIButton(type: .system)
        button.tintColor = .systemYellow
        button.contentMode = .scaleAspectFit
        panel.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 80),
            button.topAnchor.constraint(equalTo: panel.topAnchor, constant: 5),
            button.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -5)
        ])
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.addTarget(self, action: #selector(noteButtonTapped), for: .touchUpInside)
    }
    
    @objc func noteButtonTapped() {
//        print("Tapped")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.tappedNote(title: tasks[indexPath.row].title,
                           date: tasks[indexPath.row].date,
                           body: tasks[indexPath.row].body)
    }
}

extension MainViewController: TableCellOutput {
    func didTapButton(in cell: TableCell) {
        output?.toggledNote(title: cell.titleLabel.text)
        tableView.reloadData()
    }
    
    
}
