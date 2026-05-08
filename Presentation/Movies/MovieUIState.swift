//
//  MovieUIState.swift
//  MyFavouriteMovies
//
//  Created by Belema on 04/05/2026.
//

enum MovieUIState {
    case nothing
    case loading
    case loaded([MovieUIData])
    case error(_ errorMessage:String)
}
