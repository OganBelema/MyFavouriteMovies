//
//  MockRepository.swift
//  CoreModules
//
//  Created by Belema on 05/05/2026.
//
import Domain

final class MockRepository: RepositoryProtocol {
    var movies: [Movie] = []
    var favMovies: [FavouriteMovie] = []

    func getMovies() async throws -> [Movie] {
        movies
    }

    func getMovie(id: Int) async throws -> Movie? {
        movies.first { movie in
            movie.id == id
        }
    }

    func addMovies(_ movies: [Movie]) async throws {
        self.movies.append(contentsOf: movies)
    }

    func addMovie(_ movie: Movie) async throws {
        movies.append(movie)
    }

    func addFavouriteMovie(_ movie: FavouriteMovie) async throws {
        favMovies.append(movie)
    }

    func removeFavouriteMovie(_ movie: FavouriteMovie) async throws {
        let index = favMovies.firstIndex { item in
            movie.id == item.id
        }
        guard let index else {
            return
        }
        favMovies.remove(at: index)
    }

    func getFavouriteMovies() async throws -> [FavouriteMovie] {
        favMovies
    }
}
