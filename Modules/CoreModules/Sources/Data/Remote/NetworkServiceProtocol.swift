//
//  NetworkServiceProtocol.swift
//  MyFavouriteMovies
//
//  Created by Belema on 16/04/2026.
//

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(endpoint: String) async throws -> T
}
