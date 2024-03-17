//
//  MoviesListUseCase.swift
//  OneBank
//
//  Copyright © 2023 Atos. All rights reserved.
//

import Foundation
import Combine

final class MoviesListUseCase: DisposeObject, MoviesListUseCaseContract {
    // MARK: - PROPERTIES
    private let repository: MoviesListRepositoryContract

    // MARK: - INIT
    init(repository: MoviesListRepositoryContract = MoviesListRepository()) {
        self.repository = repository
        super.init()
    }

    // MARK: - EXECUTE USE CASE
    func execute(requestData: MoviesListRequest) -> AnyPublisher<MoviesListResponse, MovieAppError> {
        return repository.requestMoviesList(requestData: requestData)
    }
    
}
