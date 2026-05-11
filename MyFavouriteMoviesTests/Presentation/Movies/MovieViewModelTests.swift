import Testing
import Domain
import Foundation
@testable import MyFavouriteMovies

@MainActor
struct MovieViewModelTests {
    
    @Test
    func loadMovies_success_updatesUIStateToLoaded() async throws {
        // Arrange
        let mockInteractor = MockMovieInteractor()
        let movie = Movie(
            id: 1,
            title: "Test Movie",
            releaseDate: "2026-01-01",
            overview: "Overview",
            posterPath: "/path",
            popularity: 10.0,
            voteAverage: 8.0
        )
        mockInteractor.movies = [movie]
        mockInteractor.favouriteIds = [1]
        
        let sut = MovieViewModel(movieInteractor: mockInteractor)
        
        // Act
        await sut.loadMovies()
        
        // Assert
        if case .loaded(let movies) = sut.uiState {
            #expect(movies.count == 1)
            #expect(movies.first?.id == 1)
            #expect(movies.first?.isFavorite == true)
        } else {
            Issue.record("UI state should be .loaded")
        }
    }
    
    @Test
    func loadMovies_failure_updatesUIStateToError() async throws {
        // Arrange
        let mockInteractor = MockMovieInteractor()
        let errorMessage = "Failed to fetch"
        mockInteractor.getMoviesError = NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: errorMessage])

        let sut = MovieViewModel(movieInteractor: mockInteractor)
        
        // Act
        await sut.loadMovies()
        
        // Assert
        if case .error(let message) = sut.uiState {
            #expect(message == errorMessage)
        } else {
            Issue.record("UI state should be .error")
        }
    }

    @Test
    func toggleFavourite_updatesUIStateOptimistically() async throws {
        // Arrange
        let mockInteractor = MockMovieInteractor()
        let movie = Movie(
            id: 1,
            title: "Test Movie",
            releaseDate: "2026-01-01",
            overview: "Overview",
            posterPath: "/path",
            popularity: 10.0, voteAverage: 8.0
        )
        mockInteractor.movies = [movie]
        
        let sut = MovieViewModel(movieInteractor: mockInteractor)
        await sut.loadMovies()
        
        // Act
        sut.setFavourite(movieId: 1)
        
        // Give it a moment for the Task to start and update state
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1s
        
        // Assert
        if case .loaded(let movies) = sut.uiState {
            #expect(movies.first?.isFavorite == true)
        } else {
            Issue.record("UI state should be .loaded")
        }
    }
}
