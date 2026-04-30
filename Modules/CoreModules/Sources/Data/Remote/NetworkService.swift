//
//  NetworkService.swift
//  MyFavouriteMovies
//
//  Created by Belema on 16/04/2026.
//

import Foundation

public final class NetworkService: NetworkServiceProtocol {
    private let config: APIConfig

    public init(config: APIConfig) {
        self.config = config
    }

    public func fetch<T: Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: config.baseURL + endpoint) else { throw URLError(.badURL) }

        var request = URLRequest(url: url)
        request.setValue(config.apiKey, forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
