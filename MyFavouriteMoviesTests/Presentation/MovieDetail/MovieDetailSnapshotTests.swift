//
//  MovieDetailSnapshotTests.swift
//  MyFavouriteMovies
//
//  Created by Belema on 11/05/2026.
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import MyFavouriteMovies

class MovieDetailSnapshotTests: XCTestCase {
    func testMovieDetailView() {
        let movie = MovieUIData(
            id: 1,
            title: "Inception",
            releaseDate: "2010-07-16",
            overview: "Dom Cobb (Leonardo DiCaprio) is a thief with the rare ability to enter people's dreams and steal their secrets from their...",
            posterPath: "",
            popularity: 90.0,
            voteAverage: 8.0,
            isFavorite: true
        )
        let view = MovieDetailView(movie: movie)
        let vc = UIHostingController(rootView: view)
        assertSnapshot(of: vc, as: .image(on: .iPhone13Pro))
    }

    func testMovieDetailView_DarkMode() {
        let movie = MovieUIData(
            id: 1,
            title: "Inception",
            releaseDate: "2010-07-16",
            overview: "Dom Cobb (Leonardo DiCaprio) is a thief with the rare ability to enter people's dreams and steal their secrets from their...",
            posterPath: "",
            popularity: 90.0,
            voteAverage: 8.0,
            isFavorite: true
        )
        let view = MovieDetailView(movie: movie)
            .preferredColorScheme(.dark)
        let vc = UIHostingController(rootView: view)
        assertSnapshot(
            of: vc,
            as: .image(on: .iPhone13Pro, traits: .init(userInterfaceStyle: .dark))
        )
    }
}
