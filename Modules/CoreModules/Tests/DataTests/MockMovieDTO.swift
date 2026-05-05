//
//  MockMovieDTO.swift
//  CoreModules
//
//  Created by Belema on 05/05/2026.
//

@testable import Data

extension MovieDTO {
    static func mock(id: Int = 123, title: String = "Test Movie") -> MovieDTO {
        MovieDTO(
            adult: false,
            backdropPath: "",
            genreIDS: [],
            id: id,
            originalLanguage: "en",
            originalTitle: title,
            overview: "Overview",
            popularity: 0.0,
            posterPath: "",
            releaseDate: "2026-01-01",
            title: title,
            video: false,
            voteAverage: 0.0,
            voteCount: 0
        )
    }
}

extension MovieResponseDTO {
    static func mock(results: [MovieDTO] = [.mock()]) -> MovieResponseDTO {
        MovieResponseDTO(
            page: 1,
            results: results,
            totalPages: 1,
            totalResults: results.count
        )
    }
}
