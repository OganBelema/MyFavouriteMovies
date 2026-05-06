//
//  MovieRepositoryTest.swift
//  CoreModules
//
//  Created by Belema on 05/05/2026.
//
import XCTest
@testable import Data
import Domain

final class MovieRepositoryTest: XCTestCase {

    var mockService: MockMovieService!
    var coreDataStack: CoreDataStack!
    var movieMapper: MovieMapper!
    var favoriteMovieMapper: FavouriteMovieMapper!
    var sut: MovieRepository!

    override func setUp() {
        super.setUp()
        mockService = MockMovieService()
        coreDataStack = CoreDataStack(isInMemory: true)
        movieMapper = MovieMapper()
        favoriteMovieMapper = FavouriteMovieMapper()
        sut = MovieRepository(
            movieService: mockService,
            coreDataStack: coreDataStack,
            movieDTOMapper: MovieDTOMapper(),
            movieMapper: movieMapper,
            movieEntityMapper: MovieEntityMapper(),
            favoriteMovieMapper: favoriteMovieMapper
        )
    }

    override func tearDown() {
        mockService = nil
        coreDataStack = nil
        movieMapper = nil
        favoriteMovieMapper = nil
        sut = nil
        super.tearDown()
    }

    func test_getMovies_returnsMovies() async throws {
        // Arrange
        let movieId1 = 123
        let movieId2 = 456
        
        let movieDTO1 = MovieDTO.mock(id: movieId1, title: "Movie 1")
        let movieDTO2 = MovieDTO.mock(id: movieId2, title: "Movie 2")

        mockService.movieResponseDTO = MovieResponseDTO.mock(results: [movieDTO1, movieDTO2])

        let expectedIds = [movieId1, movieId2]

        // Act
        let movies = try await sut.getMovies()

        // Assert
        XCTAssertEqual(Set(movies.map { $0.id }), Set(expectedIds))
    }

    func test_getMovie_returnsMovieWithIdProvided() async throws {
        // Arrange
        let movieId1 = 123
        let movieId2 = 456

        let movies = [
            Movie(id: movieId1, title: "Movie 1", releaseDate: "", overview: "", posterPath: "", popularity: 8.0, voteAverage: 7.5),
            Movie(id: movieId2, title: "Movie 2", releaseDate: "", overview: "", posterPath: "", popularity: 3.8, voteAverage: 2.4)
        ]

        try await sut.addMovies(movies)

        // Act
        let movie = try await sut.getMovie(id: movieId2)

        // Assert
        XCTAssertEqual(movie?.id, movieId2)
    }

    func test_getMovie_whenNoMovieWithProvidedId_returnsNil() async throws {
        // Arrange
        let movieId1 = 123
        let movieId2 = 456

        let movie1 = Movie(id: movieId1, title: "Movie 1", releaseDate: "", overview: "", posterPath: "", popularity: 8.0, voteAverage: 7.5)

        try await sut.addMovie(movie1)

        // Act
        let movie = try await sut.getMovie(id: movieId2)

        // Assert
        XCTAssertNil(movie)
    }

    func test_addMovies_addsMoviesToDatabase() async throws {
        // Arrange
        let movieId1 = 123
        let movieId2 = 456
        let expectedIds = [movieId1, movieId2]

        let movies = [
            Movie(id: movieId1, title: "Movie 1", releaseDate: "", overview: "", posterPath: "", popularity: 8.0, voteAverage: 7.5),
            Movie(id: movieId2, title: "Movie 2", releaseDate: "", overview: "", posterPath: "", popularity: 3.8, voteAverage: 2.4)
        ]

        // Act
        try await sut.addMovies(movies)

        // Assert
        let movieEntities = try await sut.getCachedMovies()
        XCTAssertEqual(Set(movieEntities.map{ $0.id }), Set(expectedIds))
    }

    func test_addMovie_addsMovieToDatabase() async throws {
        // Arrange
        let movieId1 = 123

        let movie = Movie(id: movieId1, title: "Movie 1", releaseDate: "", overview: "", posterPath: "", popularity: 8.0, voteAverage: 7.5)

        // Act
        try await sut.addMovie(movie)

        // Assert
        let movieEntity = try await sut.getMovie(id: movieId1)
        XCTAssertEqual(movieEntity?.id, movieId1)
    }

    func test_addFavouriteMovie_addsMovietoFavouriteTable() async throws {
        // Arrange
        let movieId = 123
        let favouriteMovie = FavouriteMovie(id: movieId)

        // Act
        try await sut.addFavouriteMovie(favouriteMovie)

        // Assert
        let favourites = try await sut.getFavouriteMovies()
        XCTAssertTrue(Set(favourites.map(\.id)).contains(movieId))
    }

    func test_removeFavouriteMovie_removesMovieFromFavouriteTable() async throws {
        // Arrange
        let movieId = 123
        let favouriteMovie = FavouriteMovie(id: movieId)
        try await sut.addFavouriteMovie(favouriteMovie)

        // Act
        try await sut.removeFavouriteMovie(favouriteMovie)

        // Assert
        let favourites = try await sut.getFavouriteMovies()
        XCTAssertTrue(favourites.isEmpty)
    }
}
