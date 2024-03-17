//
//  MovieDetailsRepository.swift
//  OneBank
//
//
import Combine

final class MovieDetailsRepository: DisposeObject, MovieDetailsRepositoryContract {
    // MARK: - PROPERTIES
    private let service: MovieDetailsServiceContract

    // MARK: - INIT
    init(service: MovieDetailsServiceContract = MovieDetailsService()) {
        self.service = service

        super.init()
    }

    // MARK: - REPOSITORIES METHODS

    func requestMovieDetails(movieID: String) -> AnyPublisher<MovieDetailsResponse, MovieAppError>{
        return service.requestMovieDetails(movieID: movieID)
            .eraseToAnyPublisher()
    }

}
