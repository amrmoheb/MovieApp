//
//  MovieDetailsViewModel.swift
//  OneBank
//
//  Copyright © 2023 Atos. All rights reserved.
//

import Foundation
import Combine
import UIKit

class MovieDetailsViewModel :DisposeObject, ObservableObject{
    var  movieDetailsUseCase : MovieDetailsUseCaseContract
    @Published var movie: UIMovie
    var movieID: Int

    init(movieDetailsUseCase : MovieDetailsUseCaseContract = MovieDetailsUseCase(), movie: UIMovie = UIMovie.dummyData, movieID: Int = 0) {
        self.movieDetailsUseCase =  movieDetailsUseCase
        self.movie = movie
        self.movieID = movieID
        super.init()
    }
    func loadMovieDetails()  {
        movieDetailsUseCase.execute(movieID: movieID.toString())
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.handlingFailure(error)
                }
            } receiveValue: { [weak self] response in
               
                if let self = self {
                    movie = mapMovieToUiModel(response)
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
    func mapMovieToUiModel(_ movie: MovieDetailsResponse) -> UIMovie {
        return UIMovie(id: movie.id ,title: movie.title, overview: movie.overview)
    }
    func getMovieID() -> String {
        movie.id.toString()
    }
}
