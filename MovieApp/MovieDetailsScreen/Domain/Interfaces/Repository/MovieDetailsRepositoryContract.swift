//
//  MovieDetailsRepositoryContract.swift
//  OneBank
//
//  Copyright © 2023 Atos. All rights reserved.
//

import Foundation
import Combine

protocol MovieDetailsRepositoryContract {
    func requestMovieDetails(movieID: String) -> AnyPublisher<MovieDetailsResponse, MovieAppError>
}
