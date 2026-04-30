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

    var body: some View {
        ForEach(viewModel.movies, id: \.id) { movie in
            Text(movie.title)
        }
        .task {
            await viewModel.loadMovies()
        }
    }
}
