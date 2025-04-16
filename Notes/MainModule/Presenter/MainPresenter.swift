
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
    func didRecieveData(data: [String]) {
//        router.showMainModule(data: data)
        print("Presenter recieved from interactor data: \(data)")
        view.updateView(with: data)
    }
}

extension MainPresenter: MainViewOutput {
    func tappedNote(with text: String) {
        print("Presenter recieved from view text: \(text)")
        interactor.saveString(text)
    }
    
    
}
