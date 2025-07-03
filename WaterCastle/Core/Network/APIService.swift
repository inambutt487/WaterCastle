import Foundation

enum APIError: Error {
    case invalidResponse
    case invalidData
    case encodingError
    case networkError(Error)
}

class APIService {
    static let shared = APIService()
    private init() {}

    // MARK: - Public POST method
    func postRequest<T: Decodable, Body: Encodable>(
        endpoint: String,
        body: Body,
        headers: [String: String] = [:]
    ) async -> Result<T, Error> {
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

        do {
            request.httpBody = try JSONEncoder().encode(body)
            print("[APIService] POST Request: \(url), Body: \(body), Headers: \(headers)")
        } catch {
            print("[APIService] Encoding error: \(error)")
            return .failure(APIError.encodingError)
        }

        return await performRequest(request)
    }

    // MARK: - Generic network execution
    private func performRequest<T: Decodable>(_ request: URLRequest) async -> Result<T, Error> {
        print("[APIService] Performing request to: \(request.url?.absoluteString ?? "nil")")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("[APIService] Invalid response code")
                return .failure(APIError.invalidResponse)
            }

            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)

        } catch let error as DecodingError {
            print("[APIService] Decoding error: \(error)")
            return .failure(APIError.invalidData)
        } catch {
            print("[APIService] Network error: \(error)")
            return .failure(APIError.networkError(error))
        }
    }
}
