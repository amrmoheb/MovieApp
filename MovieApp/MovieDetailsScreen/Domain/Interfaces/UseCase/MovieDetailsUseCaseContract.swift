//
//  MovieDetailsUseCaseContract.swift
//  OneBank
//
//  Created by Amr Sultan on 09/04/2023.
//  Copyright © 2023 Atos. All rights reserved.
//

import Foundation
import Combine
protocol MovieDetailsUseCaseContract {
    func execute(movieID: String) -> AnyPublisher<MovieDetailsResponse, MovieAppError> 
}
