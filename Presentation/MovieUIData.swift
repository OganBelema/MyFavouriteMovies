//
//  MovieUIData.swift
//  MyFavouriteMovies
//
//  Created by Belema on 04/05/2026.
//

struct MovieUIData: Hashable, Identifiable {
    let id: Int
    let title: String
    let releaseDate: String
    let overview: String
    let posterPath: String
    let popularity: Double
    let voteAverage: Double
    var isFavorite: Bool
}
