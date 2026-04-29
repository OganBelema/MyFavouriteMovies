//
//  MovieMapper.swift
//  CoreModules
//
//  Created by Belema on 22/04/2026.
//
import Domain

struct MovieMapper: MapperProtocol {
    func map(_ input: MovieEntity) -> Movie {
        return Movie(
            id: Int(input.id),
            title: input.title ?? "",
            releaseDate: input.releaseDate ?? "",
            overview: input.overview ?? "",
            posterPath: input.posterPath ?? "",
            popularity: input.popularity,
            voteAverage: input.voteAverage
        )
    }
}
