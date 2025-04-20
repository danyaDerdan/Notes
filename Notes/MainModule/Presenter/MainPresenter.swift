
final class MainPresenter {
    
    var router: RouterProtocol?
    weak var view: MainViewInput?
    var interactor: MainInteractorInput
    
    init(router: RouterProtocol?, view: MainViewInput?, interactor: MainInteractorInput) {
        self.router = router
        self.view = view
        self.interactor = interactor
    }
}

extension MainPresenter: MainInteractorOutput {
    func didRecieveData(data: [ViewData.Note]) {
        view?.updateView(with: data)
    }
}

extension MainPresenter: MainViewOutput {
    
    func viewDidLoad() {
        interactor.fetchData()
    }
    
    func tappedNote(title: String?, date: String?, body: String?) {
        router?.showDetailModule(title: title ?? "", date: date ?? "", body: body ?? "", onDisappear: interactor.fetchData)
    }
    
    func toggledNote(title: String?) {
        interactor.toggleNoteWith(title: title ?? "")
    }
    
    func tappedNewNote() {
        router?.showDetailModule(title: "", date: interactor.getCurrentDate(), body: "", onDisappear: interactor.fetchData)
    }
    
    func deletedNoteWith(title: String) {
        interactor.deleteTask(with: title)
    }
}
