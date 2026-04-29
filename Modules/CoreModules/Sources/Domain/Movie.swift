//
//  Movie.swift
//  CoreModules
//
//  Created by Belema on 17/04/2026.
//

public struct Movie: Sendable {
    public let id: Int
    public let title: String
    public let releaseDate: String
    public let overview: String
    public let posterPath: String
    public let popularity: Double
    public let voteAverage: Double

    public init(id: Int, title: String, releaseDate: String, overview: String, posterPath: String, popularity: Double, voteAverage: Double) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.posterPath = posterPath
        self.popularity = popularity
        self.voteAverage = voteAverage
    }
}
