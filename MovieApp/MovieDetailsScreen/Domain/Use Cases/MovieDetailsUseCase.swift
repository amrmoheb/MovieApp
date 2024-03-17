//
//  MovieDetailsUseCase.swift
//  OneBank
//
//  Copyright © 2023 Atos. All rights reserved.
//

import Foundation
import Combine

final class MovieDetailsUseCase: DisposeObject, MovieDetailsUseCaseContract {
    // MARK: - PROPERTIES
    private let repository: MovieDetailsRepositoryContract

    // MARK: - INIT
    init(repository: MovieDetailsRepositoryContract = MovieDetailsRepository()) {
        self.repository = repository
        super.init()
    }

    // MARK: - EXECUTE USE CASE
    func execute(movieID: String) -> AnyPublisher<MovieDetailsResponse, MovieAppError> {
        return repository.requestMovieDetails(movieID: movieID)
                .eraseToAnyPublisher()
    }
}
