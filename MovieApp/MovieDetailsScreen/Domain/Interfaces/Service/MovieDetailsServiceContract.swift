//
//  MovieDetailsServiceContract.swift
//  OneBank
//
//  Copyright © 2023 Atos. All rights reserved.
//

import Foundation
import Combine
protocol MovieDetailsServiceContract {
    func requestMovieDetails(movieID: String) -> AnyPublisher<MovieDetailsResponse, MovieAppError> 
}
