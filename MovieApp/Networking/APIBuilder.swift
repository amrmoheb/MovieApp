//
//  APIBuilder.swift
//  MovieApp
//
//  Created by Amr Moheb on 08/03/2024.
//

import Foundation
import Foundation

enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }

class APIBuilder {
    private var baseURL: String = "https://api.themoviedb.org/3/"
    private var path: String = ""
    private var method: HTTPMethod = .get
    private var parameters: [String: Any] = [:]
    private var headers: [String: String] = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiY2QwYTQzN2E5OTdlYjM4ZDM0YzFlMDg4YzllYzRlZiIsInN1YiI6IjY1ZWE1NmRmYTI0MjMyMDE2MTMyYWM0ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.CLwUApEbdknymN0jBQoTmWV_4aaqW7XIwG2vNRNbWWw"
    ]

    init() {}

    func setPath(_ path: String) -> APIBuilder {
        self.path = path
        return self
    }

    func setMethod(_ method: HTTPMethod) -> APIBuilder {
        self.method = method
        return self
    }

    func setParameters(_ parameters: [String: Any]) -> APIBuilder {
        self.parameters = parameters
        return self
    }

    func setHeaders(_ headers: [String: String]) -> APIBuilder {
        self.headers = headers
        return self
    }

    func build() -> URLRequest {
        var urlString = baseURL + path
        
        // Append parameters to URL for GET requests
        if method == .get && !parameters.isEmpty {
            let queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            if var urlComponents = URLComponents(string: urlString) {
                urlComponents.queryItems = queryItems
                urlString = urlComponents.string ?? urlString
            }
        }

        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        // Include parameters in the request body for POST requests
        if method == .post {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            request.addValue("application/json", forHTTPHeaderField: "accept")
        }

        // Add default and custom headers
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}
