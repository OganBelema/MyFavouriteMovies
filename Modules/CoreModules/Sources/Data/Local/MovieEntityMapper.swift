//
//  MovieEntityMapper.swift
//  CoreModules
//
//  Created by Belema on 29/04/2026.
//
import CoreData
import Domain

struct MovieEntityMapper: PersistenceMapperProtocol {
    func map(_ input: Movie, context: NSManagedObjectContext) -> MovieEntity {
        let movieEntity = MovieEntity(context: context)
        movieEntity.id = Int64(input.id)
        movieEntity.title = input.title
        movieEntity.overview = input.overview
        movieEntity.popularity = input.popularity
        movieEntity.voteAverage = input.voteAverage
        movieEntity.posterPath = input.posterPath
        movieEntity.releaseDate = input.releaseDate
        movieEntity.createdAt = Date()
        return movieEntity
    }
}
