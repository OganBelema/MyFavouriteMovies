//
//  MovieResponseDTO.swift
//  MyFavouriteMovies
//
//  Created by Belema on 16/04/2026.
//

struct MovieResponseDTO: Codable {
    let page: Int
    let results: [MovieDTO]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
