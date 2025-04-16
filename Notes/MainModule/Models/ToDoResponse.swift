struct ToDoResponse: Decodable {
    let todos: [ToDoModel]
    
    struct ToDoModel: Decodable {
        let id: Int
        let todo: String
        let completed: Bool
    }
}
