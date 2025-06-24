import Foundation

class NetworkLoggerProtocol: URLProtocol {
    private var sessionTask: URLSessionDataTask?

    override class func canInit(with request: URLRequest) -> Bool {
        // Avoid infinite loop by checking for a custom header
        if URLProtocol.property(forKey: "NetworkLoggerHandled", in: request) != nil {
            return false
        }
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        // Mark request as handled
        let newRequest = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
        URLProtocol.setProperty(true, forKey: "NetworkLoggerHandled", in: newRequest)

        print("[NetworkLogger] Request: \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        if let headers = request.allHTTPHeaderFields {
            print("[NetworkLogger] Headers: \(headers)")
        }
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("[NetworkLogger] Body: \(bodyString)")
        }

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
        sessionTask = session.dataTask(with: newRequest as URLRequest) { data, response, error in
            if let response = response {
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                print("[NetworkLogger] Response: \(response)")
            }
            if let data = data {
                self.client?.urlProtocol(self, didLoad: data)
                if let str = String(data: data, encoding: .utf8) {
                    print("[NetworkLogger] Response Data: \(str)")
                }
            }
            if let error = error {
                self.client?.urlProtocol(self, didFailWithError: error)
                print("[NetworkLogger] Error: \(error)")
            } else {
                self.client?.urlProtocolDidFinishLoading(self)
            }
        }
        sessionTask?.resume()
    }

    override func stopLoading() {
        sessionTask?.cancel()
    }
} 