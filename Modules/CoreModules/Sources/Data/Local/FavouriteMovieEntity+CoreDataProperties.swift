//
//  FavouriteMovieEntity+CoreDataProperties.swift
//  MyFavouriteMovies
//
//  Created by Belema on 05/05/2026.
//
//

public import Foundation
public import CoreData


public typealias FavouriteMovieEntityCoreDataPropertiesSet = NSSet

extension FavouriteMovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteMovieEntity> {
        return NSFetchRequest<FavouriteMovieEntity>(entityName: "FavouriteMovieEntity")
    }

    @NSManaged public var id: Int64

}
