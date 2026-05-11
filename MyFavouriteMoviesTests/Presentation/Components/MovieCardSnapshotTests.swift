//
//  MovieCardSnapshotTests.swift
//  MyFavouriteMovies
//
//  Created by Belema on 11/05/2026.
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import MyFavouriteMovies

class MovieCardSnapshotTests: XCTestCase {
    func testMovieCard() {
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

        let view = MovieCard(movie: movie, onFavouriteToggle: {}, onTap: {})
        let vc = UIHostingController(rootView: view)
        assertSnapshot(of: vc, as: .image(on: .iPhone13Pro))
    }

    func testMovieCard_DarkMode() {
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

        let view = MovieCard(movie: movie, onFavouriteToggle: {}, onTap: {})
            .colorScheme(.dark)

        let vc = UIHostingController(rootView: view)
        assertSnapshot(
            of: vc,
            as: .image(on: .iPhone13Pro, traits: .init(userInterfaceStyle: .dark))
        )
    }
}
