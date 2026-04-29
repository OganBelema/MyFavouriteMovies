//
//  Mapper.swift
//  CoreModules
//
//  Created by Belema on 20/04/2026.
//

public protocol MapperProtocol {
    associatedtype Input
    associatedtype Output

    func map(_ input: Input) -> Output
}
