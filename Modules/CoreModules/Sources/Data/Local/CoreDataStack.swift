//
//  CoreDataManager.swift
//  CoreModules
//
//  Created by Belema on 21/04/2026.
//
import CoreData

public final class CoreDataStack: Sendable {
    public static let shared = CoreDataStack()

    private let persistentContainer: NSPersistentContainer

    public func performWrite(_ action: @escaping @Sendable (NSManagedObjectContext) throws -> Void) async throws {
        // This automatically handles the background thread for you
        try await withCheckedThrowingContinuation { continuation  in
            persistentContainer.performBackgroundTask { context in
                do {
                    // Set the merge policy to prevent conflicts
                    context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
                    try action(context)
                    try context.save()
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    public func getMovie(id: Int) async throws -> MovieEntity? {
        let context = persistentContainer.newBackgroundContext()
        return try await withCheckedThrowingContinuation { continuation in
            do {
                let request = MovieEntity.fetchRequest()
                let predicate = NSPredicate(format: "id = %@", id)
                request.predicate = predicate
                let result = try context.fetch(request).first
                continuation.resume(returning: result)
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    public func fetchMovies() async throws -> [MovieEntity] {
        let context = persistentContainer.newBackgroundContext()
        return try await withCheckedThrowingContinuation { continuation in
            context.perform {
                let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
                do {
                    let result = try context.fetch(request)
                    continuation.resume(returning: result)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    public func fetchFavouriteMovies() async throws -> [FavouriteMovieEntity] {
        let context = persistentContainer.newBackgroundContext()
        return try await withCheckedThrowingContinuation { continuation in
            let request: NSFetchRequest<FavouriteMovieEntity> = FavouriteMovieEntity.fetchRequest()
            do {
                let result = try context.fetch(request)
                continuation.resume(returning: result)
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    public func fetchFavouriteMovie(id: Int) async throws -> FavouriteMovieEntity? {
        let context = persistentContainer.newBackgroundContext()
        return try await withCheckedThrowingContinuation { continuation in
            context.perform {
                let request = FavouriteMovieEntity.fetchRequest()
                let predicate = NSPredicate(format: "id = %@", id)
                request.predicate = predicate
                do {
                    let result = try context.fetch(request).first
                    continuation.resume(returning: result)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    public func deleteFavouriteMovie(id: Int) async throws {
        try await performWrite { context in
            let request = FavouriteMovieEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", id)
            request.fetchLimit = 1

            if let entityToDelete = try context.fetch(request).first {
                context.delete(entityToDelete)
            }
        }
    }

    private init () {
        persistentContainer = NSPersistentContainer(name: "MovieModel")

        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
    }
}
