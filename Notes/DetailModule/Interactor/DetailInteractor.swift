protocol DetailInteractorInput {
    var output: DetailInteractorOutput? { get set }
}

protocol DetailInteractorOutput: AnyObject {
    func test()
}

final class DetailInteractor: DetailInteractorInput {
    weak var output: DetailInteractorOutput?
    
}
