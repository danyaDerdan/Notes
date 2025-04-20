final class DetailPresenter {
    
    weak var view: DetailViewInput?
    var interactor: DetailInteractorInput
    var router: RouterProtocol?
    var onDisappear: (() -> ())?
    
    init(view: DetailViewInput?, interactor: DetailInteractorInput, router: RouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension DetailPresenter: DetailViewOutput {
    
    func viewDidLoad() {
        interactor.fetchData()
    }
    
    func viewDidDisappear(title: String?, date: String?, body: String?) {
        interactor.saveData(title: title ?? "", date: date ?? "", body: body ?? "")
        onDisappear?()
    }
    

}

extension DetailPresenter: DetailInteractorOutput {
    func dataReceived(title: String, date: String, body: String) {
        view?.updateData(title: title, date: date, body: body)
    }
    
    func invalidTitleRecieved(recievedTitle: String, fixedTitle: String) {
        view?.showAlert(message: "Заметка с именем '\(recievedTitle)' уже существует.\nИмя заметки будет изменено на '\(fixedTitle)'")
    }
}

