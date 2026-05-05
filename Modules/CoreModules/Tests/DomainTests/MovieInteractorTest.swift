//
//  MovieInteractorTest.swift
//  CoreModules
//
//  Created by Belema on 05/05/2026.
//

import XCTest
@testable import Domain

final class MovieInteractorTest: XCTestCase {

    var repository: MockRepository!
    var sut: MovieInteractor!

    override func setUp() {
        super.setUp()
        repository = MockRepository()
        sut = MovieInteractor(repository: repository)
    }

    override func tearDown() {
        repository = nil
        sut = nil
        super.tearDown()
    }

    func test_toggleFavourite_addsFavourite_whenMovieIsNotAlreadyFavourited() async throws {
        // Arrange
        let favMovieId = 123

        repository.movies = [
            Movie(id: favMovieId, title: "Test", releaseDate: "", overview: "", posterPath: "", popularity: 0, voteAverage: 0)
        ]

        // Act
        try await sut.toggleFavourite(movieId: favMovieId)

        // Assert
        XCTAssertEqual(repository.favMovies.count, 1, "Count should be 1 to show movie was added")
        XCTAssertEqual(repository.favMovies.first?.id, favMovieId)
    }

    func test_toggleFavourite_removesFavourite_whenMovieIsAlreadyFavourited() async throws {
        // Arrange
        let favMovieId = 123

        repository.favMovies = [
            FavouriteMovie(id: favMovieId)
        ]

        // Act
        try await sut.toggleFavourite(movieId: favMovieId)

        // Assert
        XCTAssertTrue(repository.favMovies.isEmpty, "The favorites list should be empty after removal")
    }

    func test_getMovies_returnsAllMovies() async throws {
        // Arrange
        let movieId1 = 123
        let movieId2 = 456
        let expectedIds = [movieId1, movieId2]

        repository.movies = [
            Movie(id: movieId1, title: "Movie 1", releaseDate: "", overview: "", posterPath: "", popularity: 8.0, voteAverage: 7.5),
            Movie(id: movieId2, title: "Movie 2", releaseDate: "", overview: "", posterPath: "", popularity: 3.8, voteAverage: 2.4)
        ]

        // Act
        let movies = try await sut.getMovies()

        // Assert
        XCTAssertEqual(movies.map { $0.id }, expectedIds) // checks count, ids and order
    }

    func test_getFavourites_returnsOnlyFavouritedMovies() async throws {
        // Arrange
        let favMovieId = 456

        let favMovie = Movie(id: favMovieId, title: "Movie 2", releaseDate: "", overview: "", posterPath: "", popularity: 30.0, voteAverage: 5.7)

        let expectedFavIds = [favMovieId]

        repository.movies = [
            Movie(id: 123, title: "Movie 1", releaseDate: "", overview: "", posterPath: "", popularity: 0.0, voteAverage: 0.0),
            favMovie,
            Movie(id: 789, title: "Movie 3", releaseDate: "", overview: "", posterPath: "", popularity: 60.7, voteAverage: 10.0)
        ]

        repository.favMovies = [
            FavouriteMovie(id: favMovieId)
        ]

        // Act
        let favMovies = try await sut.getFavourites()

        // Assert
        XCTAssertEqual(favMovies.map { $0.id }, expectedFavIds)
    }
}
