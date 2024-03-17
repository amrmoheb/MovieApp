//
//  MovieDetailsService.swift
//  OneBank
//
//  Copyright © 2023 Atos. All rights reserved.
//

import Combine

final class MovieDetailsService: DisposeObject, MovieDetailsServiceContract {
    // MARK: - Properties
    var apiService: APIServiceContract

    init(apiService: APIServiceContract = APIService.shared) {
        self.apiService = apiService
        super.init()
    }

    // MARK: - SERVICE METHODS
    func requestMovieDetails(movieID: String) -> AnyPublisher<MovieDetailsResponse, MovieAppError> {
        let request = APIBuilder()
            .setPath( "movie/\(movieID)?language=en-US")
            .setMethod(.get)
            .setParameters([:])
            .build()

        return apiService
            .performRequest(request,
                            decodingType: MovieDetailsResponse.self)
    }
}


