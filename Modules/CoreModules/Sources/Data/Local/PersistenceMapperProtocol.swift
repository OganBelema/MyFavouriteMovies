//
//  PersistenceMapperProtocol.swift
//  CoreModules
//
//  Created by Belema on 29/04/2026.
//
import Domain

protocol PersistenceMapperProtocol {
    associatedtype Input
    associatedtype Output
    associatedtype Context

    func map(_ input: Input, context: Context) -> Output
}
