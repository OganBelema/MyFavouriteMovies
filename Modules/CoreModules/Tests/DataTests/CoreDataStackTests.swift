import XCTest
import CoreData
@testable import Data
import Domain

final class CoreDataStackTests: XCTestCase {
    var sut: CoreDataStack!

    override func setUp() {
        super.setUp()
        // Initialize with in-memory store for every test
        sut = CoreDataStack(isInMemory: true)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_performWrite_addsMovieToDatabase() async throws {
        // Arrange
        let movieId = 123
        
        // Act
        try await sut.performWrite { context in
            let entity = MovieEntity(context: context)
            entity.id = Int64(movieId)
            entity.title = "Test Movie"
            entity.overview = "Test Overview"
            entity.posterPath = "/test.jpg"
            entity.releaseDate = "2026-05-04"
            entity.popularity = 10.0
            entity.voteAverage = 8.5
            entity.createdAt = Date()
        }
        
        // Assert
        let mapper = MovieMapper()
        let movie = try await sut.getMovie(id: movieId, movieMapper: mapper)
        XCTAssertNotNil(movie)
        XCTAssertEqual(movie?.id, movieId)
        XCTAssertEqual(movie?.title, "Test Movie")
    }

    func test_fetchMovies_returnsAllMoviesFromDatabase() async throws {
        // Arrange
        let movieId1 = 123
        let movieId2 = 456

        try await sut.performWrite { context in
            let entity1 = MovieEntity(context: context)
            entity1.id = Int64(movieId1)
            entity1.title = "Entity 1"
            entity1.overview = "Entity 1 Overview"
            entity1.posterPath = ""
            entity1.releaseDate = "2026-04-05"
            entity1.popularity = 5.0
            entity1.voteAverage = 7.0
            entity1.createdAt = Date()

            let entity2 = MovieEntity(context: context)
            entity2.id = Int64(movieId2)
            entity2.title = "Entity 2"
            entity2.overview = "Entity 2 Overview"
            entity2.posterPath = ""
            entity2.releaseDate = "2026-04-05"
            entity2.popularity = 6.2
            entity2.voteAverage = 4.8
            entity2.createdAt = Date()
        }

        // Act
        let movieMapper = MovieMapper()
        let movies = try await sut.fetchMovies(movieMapper: movieMapper)

        // Assert
        XCTAssertEqual(movies.count, 2, "Should have returned exactly 2 movies")
        let movieIds = movies.map { $0.id }
        XCTAssertTrue(movieIds.contains(movieId1))
        XCTAssertTrue(movieIds.contains(movieId2))
    }

    func test_fetchFavouriteMovies_returnsAllFavouriteMoviesFromDatabase() async throws {
        // Arrange
        let favMovieId1 = 123
        let favMovieId2 = 456

        try await sut.performWrite { context in
            let favMovie1 = FavouriteMovieEntity(context: context)
            favMovie1.id = Int64(favMovieId1)

            let favMovie2 = FavouriteMovieEntity(context: context)
            favMovie2.id = Int64(favMovieId2)
        }

        // Act
        let favouriteMovieMapper = FavouriteMovieMapper()
        let favMovies = try await sut.fetchFavouriteMovies(favouriteMovieMapper: favouriteMovieMapper)

        // Assert
        XCTAssertEqual(favMovies.count, 2, "Should have returned exactly 2 fav movies")
        let favIds = favMovies.map { $0.id }
        XCTAssertTrue(favIds.contains(favMovieId1))
        XCTAssertTrue(favIds.contains(favMovieId2))
    }

    func test_deleteFavouriteMovie_removesMovieFromDatabase() async throws {
        // Arrange
        let movieId = 456
        try await sut.performWrite { context in
            let entity = FavouriteMovieEntity(context: context)
            entity.id = Int64(movieId)
        }

        // Act
        try await sut.deleteFavouriteMovie(id: movieId)

        // Assert
        let mapper = FavouriteMovieMapper()
        let movie = try await sut.fetchFavouriteMovie(id: movieId, favouriteMovieMapper: mapper)
        XCTAssertNil(movie)
    }

    func test_performWrite_rethrowsError_whenActionThrows() async {
        // Arrange
        enum TestError: Error {
            case someError
        }
        
        // Act & Assert
        do {
            try await sut.performWrite { _ in
                throw TestError.someError
            }
            XCTFail("performWrite should have thrown an error")
        } catch {
            XCTAssertEqual(error as? TestError, .someError)
        }
    }
}
