enum ViewData {
    case success([Note])
    
    struct Note {
        let title: String
        let body: String
        let date: String
        let isDone: Bool
    }
}
