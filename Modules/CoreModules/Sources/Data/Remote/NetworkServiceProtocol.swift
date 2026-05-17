//
//  NetworkServiceProtocol.swift
//  MyFavouriteMovies
//
//  Created by Belema on 16/04/2026.
//

public protocol NetworkServiceProtocol: Sendable {
    func fetch<T: Decodable>(endpoint: String) async throws -> T
}
