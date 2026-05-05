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
    var sut: MovieRepository!

    override func setUp() {
        super.setUp()
        mockService = MockMovieService()
        sut = MovieRepository(
            movieService: mockService,
            coreDataStack: CoreDataStack(isInMemory: true),
            movieDTOMapper: MovieDTOMapper(),
            movieMapper: MovieMapper(),
            movieEntityMapper: MovieEntityMapper(),
            favoriteMovieMapper: FavouriteMovieMapper()
        )
    }

    override func tearDown() {
        mockService = nil
        sut = nil
        super.tearDown()
    }

    func test_getMovies_returnsMovies() async throws {
        // Arrange
        let movieDTO1 = MovieDTO.mock(id: 123, title: "Movie 1")
        let movieDTO2 = MovieDTO.mock(id: 456, title: "Movie 2")

        mockService.movieResponseDTO = MovieResponseDTO.mock(results: [movieDTO1, movieDTO2])

        let movie1 = Movie(
            id: movieDTO1.id,
            title: movieDTO1.title,
            releaseDate: movieDTO1.releaseDate,
            overview: movieDTO1.overview,
            posterPath: movieDTO1.posterPath,
            popularity: movieDTO1.popularity,
            voteAverage: movieDTO1.voteAverage
        )

        let movie2 = Movie(
            id: movieDTO2.id,
            title: movieDTO2.title,
            releaseDate: movieDTO2.releaseDate,
            overview: movieDTO2.overview,
            posterPath: movieDTO2.posterPath,
            popularity: movieDTO2.popularity,
            voteAverage: movieDTO2.voteAverage
        )

        let expectedMovies = [movie1, movie2]

        // Act
        let movies = try await sut.getMovies()

        // Assert
        XCTAssertEqual(movies.map { $0.id }, expectedMovies.map { $0.id })
    }

}
