//
//  MoviesListViewModel.swift
//  OneBank
//
//  Copyright © 2023 Atos. All rights reserved.
//

import Foundation
import Combine
import UIKit

class MoviesListViewModel : DisposeObject, ObservableObject{
    var moviesListUseCase : MoviesListUseCaseContract
    @Published var movies: [UIMovie] = []
    @Published var favoriteMovieID: String = ""

    init(moviesListUseCase : MoviesListUseCaseContract = MoviesListUseCase()) {
        self.moviesListUseCase = moviesListUseCase
        super.init()
    }

    func loadMovieList()  {
        let request = MoviesListRequest()
        moviesListUseCase.execute(requestData: request)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.handlingFailure(error)
                }
            }  receiveValue: { [weak self] response in
                if let self = self {
                    movies = mapMoviesToUiModel(response.results)
                }
            }
            .store(in: &cancellables)
    }
    func handlingFailure(_ error: Error) {
        var errorMessage = ""
        switch error {
        case MovieAppError.invalidResponse:
            errorMessage = "Invalid response from the server."
        case MovieAppError.networkError:
            errorMessage = "Network error occurred. Please check your internet connection and try again."
        default:
            errorMessage = "An unknown error occurred."
        }
        
        // Presenting alert
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    func mapMoviesToUiModel(_ movies: [Movie]) -> [UIMovie] {
        return movies.map { movie in
            return UIMovie(id: movie.id, title: movie.title, overview: movie.overview)
        }
    }
}
