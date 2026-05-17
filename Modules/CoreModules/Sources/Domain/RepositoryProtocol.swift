//
//  RepositoryProtocol.swift
//  CoreModules
//
//  Created by Belema on 17/04/2026.
//

public protocol RepositoryProtocol: Sendable {
    func getMovies() async throws -> [Movie]
    func getMovie(id: Int) async throws -> Movie?
    func addMovies(_ movies: [Movie]) async throws
    func addMovie(_ movie: Movie) async throws
    func addFavouriteMovie(_ movie: FavouriteMovie) async throws
    func removeFavouriteMovie(_ movie: FavouriteMovie) async throws
    func getFavouriteMovies() async throws -> [FavouriteMovie]
}
