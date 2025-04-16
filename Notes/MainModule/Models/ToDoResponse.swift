struct ToDoResponse: Decodable {
    let todos: [ToDo]
    
    struct ToDo: Decodable {
        let id: Int
        let todo: String
        let completed: Bool
    }
}
