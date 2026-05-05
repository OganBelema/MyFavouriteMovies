//
//  MovieEntity+CoreDataProperties.swift
//  MyFavouriteMovies
//
//  Created by Belema on 05/05/2026.
//
//

public import Foundation
public import CoreData


public typealias MovieEntityCoreDataPropertiesSet = NSSet

extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var id: Int64
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Double

}
