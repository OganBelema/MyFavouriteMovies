//
//  MovieViewModel.swift
//  MyFavouriteMovies
//
//  Created by Belema on 30/04/2026.
//

import Domain
import Combine
import Foundation

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    private let movieInteractor: MovieInteractorProtocol

    init(movieInteractor: MovieInteractor) {
        self.movieInteractor = movieInteractor
    }

    @MainActor
    func loadMovies() async {
        do {
            movies = try await movieInteractor.getMovies()
        } catch {
            print(error.localizedDescription)
        }
    }
}
