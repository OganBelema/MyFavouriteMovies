//
//  FavouriteMovieMapper.swift
//  CoreModules
//
//  Created by Belema on 29/04/2026.
//
import Domain

public struct FavouriteMovieMapper: MapperProtocol, Sendable {

    public init() {}

    public func map(_ imput: FavouriteMovieEntity) -> FavouriteMovie {
        return FavouriteMovie(id: Int(imput.id))
    }
}
