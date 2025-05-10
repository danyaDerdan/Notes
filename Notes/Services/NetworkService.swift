import Foundation

protocol NetworkServiceProtocol {
    func fetchData(from stringUrl: String, completion: @escaping (Result<ToDoResponse, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func fetchData(from stringUrl: String, completion: @escaping (Result<ToDoResponse, Error>) -> Void) {
        guard let url = URL(string: stringUrl) else {
            completion(.failure(NetworkError.invalidURL))
            return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(error))
                return }
            guard let data else {
                completion(.failure(NetworkError.invalidData))
                return }
            let decoder = JSONDecoder()
            guard let result = try? decoder.decode(ToDoResponse.self, from: data) else {
                completion(.failure(NetworkError.decodingFailed))
                return}
            completion(.success(result))
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case decodingFailed
}
