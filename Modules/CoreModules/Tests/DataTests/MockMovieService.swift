//
//  MockMovieService.swift
//  CoreModules
//
//  Created by Belema on 05/05/2026.
//
import Data

final class MockMovieService: MovieServiceProtocol {
    var movieResponseDTO = MovieResponseDTO.mock()

    func fetchPopularMovies() async throws -> MovieResponseDTO {
        movieResponseDTO
    }
}
