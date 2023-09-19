import Foundation

enum APIEndpoint: String {
    case test = "/test"
    case testMessage = "/test/message"
    case sendMessage = "/send/message"
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

// 3. APIManager Class
class APIManager {
    
    static let shared = APIManager()
    private let baseURL = "http://158.247.255.105:8000"
    private let session = URLSession.shared
    
    private init() {}
    
    func fetchTestData(completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = APIEndpoint.test.rawValue
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.get.rawValue
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            if let message = String(data: data, encoding: .utf8) {
                completion(.success(message))
            } else {
                completion(.failure(APIError.dataDecodingError))
            }
        }
        
        task.resume()
    }
    
    
}

// 4. Completion Handlers and Errors
enum APIError: Error {
    case invalidURL
    case invalidResponse
    case dataDecodingError
    case dataEncodingError
    case unknownError
}
