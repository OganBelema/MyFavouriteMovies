//
//  ApiConfig.swift
//  MyFavouriteMovies
//
//  Created by Belema on 10/04/2026.
//

public struct APIConfig: Sendable {
    public let baseURL: String
    public let apiKey: String

    public init(baseURL: String, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
}
