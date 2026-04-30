//
//  MovieServiceProtocol.swift
//  MyFavouriteMovies
//
//  Created by Belema on 16/04/2026.
//

public protocol MovieServiceProtocol {
    func fetchPopularMovies() async throws -> MovieResponseDTO
}
