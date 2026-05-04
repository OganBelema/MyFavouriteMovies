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
}
