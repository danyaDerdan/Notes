import UIKit

protocol MainViewInput: AnyObject {
    var output: MainViewOutput? { get }
    func updateView(with data: [ViewData.Note])
}

protocol MainViewOutput {
    func tappedNote(title: String?, date: String?, body: String?)
    func toggledNote(title: String?)
    func viewDidLoad()
    func tappedNewNote()
    func deletedNoteWith(title: String)
}

class MainViewController: UIViewController, MainViewInput {
    private let searchController = UISearchController(searchResultsController: nil)
    var output: MainViewOutput?
    private var tasks: [ViewData.Note] = []
    private var filteredNotes: [ViewData.Note] = []
    private lazy var tableView = createTableView()
    
    func updateView(with data: [ViewData.Note]) {
        tasks = data
        filterNotes(for: searchController.searchBar.text ?? "")
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        output?.viewDidLoad()
        title = "Заметки"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupPanel()
        setupSearchController()
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
        output?.tappedNewNote()
    }
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск заметок"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchController.isActive ? filteredNotes.count : tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableCell else {
            return UITableViewCell()
        }
        let note = searchController.isActive ? filteredNotes[indexPath.row] : tasks[indexPath.row]
        cell.configure(with: note, output: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.tappedNote(title: (searchController.isActive ? filteredNotes : tasks)[indexPath.row].title,
                           date: (searchController.isActive ? filteredNotes : tasks)[indexPath.row].date,
                           body: (searchController.isActive ? filteredNotes : tasks)[indexPath.row].body)
    }
    
 
    
    func tableView(_ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction( style: .destructive, title: "Удалить") { [weak self] (_, _, completion) in
            guard let self else { return }
            if searchController.isActive {
                output?.deletedNoteWith(title: filteredNotes[indexPath.row].title)
                filteredNotes.remove(at: indexPath.row)
            } else {
                output?.deletedNoteWith(title: tasks[indexPath.row].title)
                tasks.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
    
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
    
}

extension MainViewController: TableCellOutput {
    func didTapButton(in cell: TableCell) {
        output?.toggledNote(title: cell.titleLabel.text)
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        filterNotes(for: searchText)
    }
    
    private func filterNotes(for searchText: String) {
        if searchText.isEmpty {
            filteredNotes = tasks
        } else {
            filteredNotes = tasks.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}
