//
//  FavouriteMovieMapper.swift
//  CoreModules
//
//  Created by Belema on 29/04/2026.
//
import Domain

struct FavouriteMovieMapper: MapperProtocol {
    func map(_ imput: FavouriteMovieEntity) -> FavouriteMovie {
        return FavouriteMovie(id: Int(imput.id))
    }
}
