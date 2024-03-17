//
//  MoviesListRepositoryContract.swift
//  OneBank
//
//  Copyright © 2023 Atos. All rights reserved.
//

import Foundation
import Combine

protocol MoviesListRepositoryContract {
    func requestMoviesList(requestData: MoviesListRequest) -> AnyPublisher<MoviesListResponse, MovieAppError>
}
