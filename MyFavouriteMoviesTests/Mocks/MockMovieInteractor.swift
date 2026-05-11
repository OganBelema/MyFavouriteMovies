import Foundation
import Domain

class MockMovieInteractor: MovieInteractorProtocol {
    var movies: [Movie] = []
    var favouriteIds: Set<Int> = []
    var getMoviesError: Error?
    var getFavouriteIdsError: Error?
    var toggleFavouriteError: Error?

    func getMovies() async throws -> [Movie] {
        if let error = getMoviesError {
            throw error
        }
        return movies
    }

    func toggleFavourite(movieId: Int) async throws {
        if let error = toggleFavouriteError {
            throw error
        }
        if favouriteIds.contains(movieId) {
            favouriteIds.remove(movieId)
        } else {
            favouriteIds.insert(movieId)
        }
    }

    func getFavourites() async throws -> [Movie] {
        return movies.filter { favouriteIds.contains($0.id) }
    }

    func getFavouriteIds() async throws -> Set<Int> {
        if let error = getFavouriteIdsError {
            throw error
        }
        return favouriteIds
    }
}
