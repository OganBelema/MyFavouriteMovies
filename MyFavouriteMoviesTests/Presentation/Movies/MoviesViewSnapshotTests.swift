//
//  MoviesViewSnapshotTests.swift
//  MyFavouriteMovies
//
//  Created by Belema on 11/05/2026.
//

import Domain
import SnapshotTesting
import SwiftUI
import XCTest
@testable import MyFavouriteMovies

@MainActor
class MoviesViewSnapshotTests: XCTestCase {
    func testMoviesView() {
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
        let movie2 = Movie(
            id: 2,
            title: "Inception",
            releaseDate: "2010-07-16",
            overview: "Dom Cobb (Leonardo DiCaprio) is a thief with the rare ability to enter people's dreams and steal their secrets from their...",
            posterPath: "",
            popularity: 90.0,
            voteAverage: 8.0
        )
        mockInteractor.movies = [movie, movie2]
        mockInteractor.favouriteIds = [1]
        let viewmodel = MovieViewModel(movieInteractor: mockInteractor)
        let view = MoviesView(viewModel: viewmodel)
        let vc = UIHostingController(rootView: view)
        assertSnapshot(of: vc, as: .image(on: .iPhone13Pro))
    }

    func testMoviesView_DarkMode() {
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
        let movie2 = Movie(
            id: 2,
            title: "Inception",
            releaseDate: "2010-07-16",
            overview: "Dom Cobb (Leonardo DiCaprio) is a thief with the rare ability to enter people's dreams and steal their secrets from their...",
            posterPath: "",
            popularity: 90.0,
            voteAverage: 8.0
        )
        mockInteractor.movies = [movie, movie2]
        mockInteractor.favouriteIds = [1]
        let viewmodel = MovieViewModel(movieInteractor: mockInteractor)
        let view = MoviesView(viewModel: viewmodel)
            .colorScheme(.dark)
        let vc = UIHostingController(rootView: view)
        assertSnapshot(of: vc, as: .image(on: .iPhone13Pro))
    }
}
