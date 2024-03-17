//
//  APIService.swift
//  MovieApp
//
//  Created by Amr Moheb on 08/03/2024.
//

import Foundation
import Combine
class APIService: APIServiceContract {
    
    static var shared : APIService = APIService()
    func performRequest<T: Decodable>(_ request: URLRequest, decodingType: T.Type) -> AnyPublisher<T, MovieAppError> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                print(response)
                guard let httpResponse = response as? HTTPURLResponse,
                      100..<300 ~= httpResponse.statusCode else {

                    throw MovieAppError.networkError
                }

                // Print response details
                print("Response Code: \(httpResponse.statusCode)")
                print("Response Status: \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
                // Print the received JSON data for inspection
                            if let jsonString = String(data: data, encoding: .utf8) {
                                print("Received JSON data: \(jsonString)")
                            } else {
                                print("Failed to convert data to UTF-8 string")
                            }
                // You can print the response data if needed
                // print("Response Data: \(String(data: data, encoding: .utf8) ?? "")")

                return data
            }
            .decode(type: decodingType, decoder: JSONDecoder())
            .mapError { error -> MovieAppError in
                if let urlError = error as? URLError {
                    return MovieAppError.networkError
                } else {
                    return MovieAppError.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }


    private static var cancellables: Set<AnyCancellable> = []
}

enum MovieAppError: Error {
    case invalidResponse
    case networkError
    // Add more custom errors as needed
}
