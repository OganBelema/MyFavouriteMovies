//
//  MoviesView.swift
//  MyFavouriteMovies
//
//  Created by Belema on 30/04/2026.
//

import Domain
import SwiftUI

struct MoviesView: View {
    @ObservedObject var viewModel: MovieViewModel
    @EnvironmentObject var coordinator: MovieCoordinator

    var body: some View {
        Group {
            switch viewModel.uiState {
                case .nothing:
                    Color.clear
                case .loading:
                    ProgressView()
                case .loaded(let movies):
                    ScrollView {
                        LazyVStack {
                            ForEach(movies, id: \.id) { movie in
                                MovieCard(movie: movie) {
                                    viewModel.setFavourite(movieId: movie.id)
                                } onTap: {
                                    coordinator.push(.detail(movie))
                                }
                                .padding()
                            }
                        }
                    }
                case .error(_):
                    Color.clear
            }
        }
        .navigationTitle("Movies")
        .task {
            await viewModel.loadMovies()
        }
    }
}
