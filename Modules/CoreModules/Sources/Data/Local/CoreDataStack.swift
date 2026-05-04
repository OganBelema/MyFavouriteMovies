//
//  CoreDataManager.swift
//  CoreModules
//
//  Created by Belema on 21/04/2026.
//
import CoreData
import Domain

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

    public func getMovie(id: Int, movieMapper: MovieMapper) async throws -> Movie? {
        let context = persistentContainer.newBackgroundContext()
        return try await withCheckedThrowingContinuation { continuation in
            context.perform {
                do {
                    let request = MovieEntity.fetchRequest()
                    request.predicate = NSPredicate(format: "id = %d", id)
                    let result = try context.fetch(request).first
                    let movie = result.map { movieEntity in
                        movieMapper.map(movieEntity)
                    }
                    continuation.resume(returning: movie)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    public func fetchMovies(movieMapper: MovieMapper) async throws -> [Movie] {
        let context = persistentContainer.newBackgroundContext()
        return try await withCheckedThrowingContinuation { continuation in
            context.perform {
                let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
                do {
                    let result = try context.fetch(request)
                    let movies = result.map { movieEntity in
                        movieMapper.map(movieEntity)
                    }
                    continuation.resume(returning: movies)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    public func fetchFavouriteMovies(favouriteMovieMapper: FavouriteMovieMapper) async throws -> [FavouriteMovie] {
        let context = persistentContainer.newBackgroundContext()
        return try await withCheckedThrowingContinuation { continuation in
            context.perform {
                let request: NSFetchRequest<FavouriteMovieEntity> = FavouriteMovieEntity.fetchRequest()
                do {
                    let result = try context.fetch(request)
                    let favouriteMovies = result.map { favouriteMovieEntity in
                        favouriteMovieMapper.map(favouriteMovieEntity)
                    }
                    continuation.resume(returning: favouriteMovies)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    public func fetchFavouriteMovie(id: Int, favouriteMovieMapper: FavouriteMovieMapper) async throws -> FavouriteMovie? {
        let context = persistentContainer.newBackgroundContext()
        return try await withCheckedThrowingContinuation { continuation in
            context.perform {
                let request = FavouriteMovieEntity.fetchRequest()
                let predicate = NSPredicate(format: "id = %d", id)
                request.predicate = predicate
                do {
                    let result = try context.fetch(request).first
                    let favouriteMovie = result.map { favouriteMovieEntity in
                        favouriteMovieMapper.map(favouriteMovieEntity)
                    }
                    continuation.resume(returning: favouriteMovie)
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

    public init(isInMemory: Bool = false) {
        // 1. Find the compiled model file (.momd) in the PACKAGE bundle
        guard let modelURL = Bundle.module.url(forResource: "MovieModel", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("CoreDataStack: Could not find MovieModel.momd in Bundle.module")
        }

        persistentContainer = NSPersistentContainer(name: "MovieModel", managedObjectModel: model)

        if isInMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            persistentContainer.persistentStoreDescriptions = [description]
        }

        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
    }
}
