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
        print("[APIService] Performing request to: \(request.url?.absoluteString ?? "nil")")
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            print("[APIService] Received response: \(response)")
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("[APIService] Invalid response code")
                return .failure(APIError.invalidResponse)
            }
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            print("[APIService] Decoded data: \(decodedData)")
            return .success(decodedData)
        } catch let error as DecodingError {
            print("[APIService] Decoding error: \(error)")
            return .failure(APIError.invalidData)
        } catch {
            print("[APIService] Network error: \(error)")
            return .failure(APIError.networkError(error))
        }
    }

    func postRequest<T: Decodable>(endpoint: String, body: [String: Any], headers: [String: String] = [:]) async -> Result<T, Error> {
        guard let url = URL(string: Constants.API.baseURL + endpoint) else {
            print("[APIService] Invalid URL: \(Constants.API.baseURL + endpoint)")
            return .failure(APIError.invalidResponse)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        print("[APIService] POST Request: \(url), Body: \(body), Headers: \(headers)")
        return await performRequest(request)
    }
} 