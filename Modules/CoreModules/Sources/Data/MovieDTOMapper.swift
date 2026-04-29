//
//  MapperProtocol.swift
//  CoreModules
//
//  Created by Belema on 20/04/2026.
//
import CoreData
import Domain

struct MovieDTOMapper: PersistenceMapperProtocol {

    func map(_ input: MovieDTO, context: NSManagedObjectContext) -> MovieEntity {
        let movie = MovieEntity(context: context)
        movie.id = Int64(input.id)
        movie.title = input.title
        movie.overview = input.overview
        movie.posterPath = input.posterPath
        movie.releaseDate = input.releaseDate
        movie.voteAverage = input.voteAverage
        movie.popularity = input.popularity
        movie.createdAt = Date()
        return movie
    }
}
