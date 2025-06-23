import Foundation

enum APIError: Error {
    case invalidResponse
    case invalidData
    case networkError(Error)
}

class APIService {
    static let shared = APIService()
    private init() {}
    
    func performRequest<T: Decodable>(_ request: URLRequest) async -> Result<T, Error> {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return .failure(APIError.invalidResponse)
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return .success(decodedData)
        } catch let error as DecodingError {
            return .failure(APIError.invalidData)
        } catch {
            return .failure(APIError.networkError(error))
        }
    }
} 