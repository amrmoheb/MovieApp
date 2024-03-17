//
//  MoviesListView.swift
//  MovieApp
//
//  Created by Amr Moheb on 08/03/2024.
//

import SwiftUI

struct UIMovie: Identifiable {
    let id : Int
    let title: String
    let overview: String
    var isFavorite: Bool = false
    
    static var dummyData: UIMovie {
        return UIMovie(id: 0, title: "", overview: "")
    }
}

struct MoviesListView: View {
    @State private var searchText: String = ""
    @ObservedObject var viewModel: MoviesListViewModel = .init()
    var filteredMovies: [UIMovie] {
       if searchText.isEmpty {
            return viewModel.movies
        } else {
            return viewModel.movies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                
                
                List(filteredMovies) { movie in
                    NavigationLink(destination: MovieDetailView(viewModel: MovieDetailsViewModel(movieID: movie.id))) {
                        MovieRow(movie: movie)
                    }
                }
            }.padding()
            .navigationTitle("Trending Movies")
        }.onAppear() {
            viewModel.loadMovieList()
        }
    }
}

struct MovieRow: View {
    let movie: UIMovie
    
    var body: some View {
        HStack {
            Text(movie.title)
            Spacer()
            if movie.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
            
        }
        .padding(.vertical)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
