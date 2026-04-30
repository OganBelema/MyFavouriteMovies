//
//  MovieInteractorProtocol.swift
//  CoreModules
//
//  Created by Belema on 20/04/2026.
//

public protocol MovieInteractorProtocol {
    func getMovies() async throws -> [Movie]
    func toggleFavourite(movieId: Int) async throws
    func getFavourites() async throws -> [Movie]
}
