//
//  AppConfig.swift
//  MyFavouriteMovies
//
//  Created by Belema on 10/04/2026.
//


enum ApiConstants {
    static var baseURL: String {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
            fatalError("BaseURL not found in Info.plist")
        }
        return url
    }
    static var apiKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API_KEY not found in Info.plist")
        }
        return apiKey
    }
}
