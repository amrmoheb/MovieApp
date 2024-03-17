//
//  APIServiceContract.swift
//  MovieApp
//
//  Created by Amr Moheb on 08/03/2024.
//

import Foundation
import Combine
protocol APIServiceContract {
    func performRequest<T: Decodable>(_ request: URLRequest, decodingType: T.Type) -> AnyPublisher<T, MovieAppError>
}
