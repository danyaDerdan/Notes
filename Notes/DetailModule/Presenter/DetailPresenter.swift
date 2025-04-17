final class DetailPresenter {
    
    weak var view: DetailViewInput?
    var interactor: DetailInteractorInput
    var router: RouterProtocol?
    
    init(view: DetailViewInput?, interactor: DetailInteractorInput, router: RouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension DetailPresenter: DetailViewOutput {
    
    func viewDidLoad() {
        interactor.output?.test()
    }
    
    func didTapBackButton(title: String) {
        
    }
}

extension DetailPresenter: DetailInteractorOutput {
    func test() {
        print("Connected")
    }
}

