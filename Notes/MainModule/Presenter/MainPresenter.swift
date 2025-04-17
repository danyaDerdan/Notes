
final class MainPresenter {
    
    var router: RouterProtocol?
    var view: MainViewInput
    var interactor: MainInteractorInput
    
    init(router: RouterProtocol?, view: MainViewInput, interactor: MainInteractorInput) {
        self.router = router
        self.view = view
        self.interactor = interactor
    }
}

extension MainPresenter: MainInteractorOutput {
    func didRecieveData(data: [ViewData.Note]) {
        view.updateView(with: data)
    }
}

extension MainPresenter: MainViewOutput {
    
    func viewDidLoad() {
        interactor.fetchData()
    }
    
    func tappedNote(with text: String) {
        print("Presenter recieved from view text: \(text)")
    }
    
    func toggledNote(title: String?) {
        interactor.toggleNoteWith(title: title ?? "")
        router?.showDetailModule(title: title ?? "")
    }
    
}
