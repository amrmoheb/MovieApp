//
//  MovieDetailsView.swift
//  MovieApp
//
//  Created by Amr Moheb on 08/03/2024.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel = .init()

    var body: some View {
        VStack {
            HStack{
                Text(viewModel.movie.title)
                    .font(.title)
                    .padding()
                Spacer()
                
            }
            Text(viewModel.movie.overview)
                .padding()

            Spacer()
        }.onAppear(){
            viewModel.loadMovieDetails()
        }
    }
}
