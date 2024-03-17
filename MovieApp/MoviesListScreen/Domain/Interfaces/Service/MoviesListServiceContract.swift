//
//  MoviesListServiceContract.swift
//  OneBank
//
//  Copyright © 2023 Atos. All rights reserved.
//

import Foundation
import Combine
protocol MoviesListServiceContract {
    func requestMoviesList(requestData: MoviesListRequest) -> AnyPublisher<MoviesListResponse, MovieAppError> 
}
