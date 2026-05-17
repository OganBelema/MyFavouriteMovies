//
//  MovieRequest.swift
//  MyFavouriteMovies
//
//  Created by Belema on 10/04/2026.
//

public final class MovieService: MovieServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let endpoint = "3/movie/popular"

    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    public func fetchPopularMovies() async throws -> MovieResponseDTO {
        try await networkService.fetch(endpoint: endpoint)
    }
}
