//
//  MovieRequest.swift
//  MyFavouriteMovies
//
//  Created by Belema on 10/04/2026.
//

public class MovieService: MovieServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let endpoint = "3/movie/popular"

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchPopularMovies() async throws -> MovieResponseDTO {
        try await networkService.fetch(endpoint: endpoint)
    }
}
