//
//  MoviesListRepository.swift
//  OneBank
//
//
import Combine

final class MoviesListRepository: DisposeObject, MoviesListRepositoryContract {
    // MARK: - PROPERTIES
    private let service: MoviesListServiceContract

    // MARK: - INIT
    init(service: MoviesListServiceContract = MoviesListService()) {
        self.service = service

        super.init()
    }

    // MARK: - REPOSITORIES METHODS

    func requestMoviesList(requestData: MoviesListRequest) -> AnyPublisher<MoviesListResponse, MovieAppError>{
        return service.requestMoviesList(requestData: requestData)
            .eraseToAnyPublisher()
    }

}
