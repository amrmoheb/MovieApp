//
//  MoviesListService.swift
//  OneBank
//
//  Copyright © 2023 Atos. All rights reserved.
//

import Combine

final class MoviesListService: DisposeObject, MoviesListServiceContract {
    // MARK: - Properties
    var apiService: APIServiceContract

    init(apiService: APIServiceContract = APIService.shared) {
        self.apiService = apiService
        super.init()
    }

    // MARK: - SERVICE METHODS
    func requestMoviesList(requestData: MoviesListRequest) -> AnyPublisher<MoviesListResponse, MovieAppError> {
        let request = APIBuilder()
            .setPath("discover/movie")
            .setMethod(.get)
            .build()

        return apiService
            .performRequest(
                request,
                decodingType: MoviesListResponse.self
            )
    }
}


