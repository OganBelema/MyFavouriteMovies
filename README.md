# MyFavouriteMovies

A modern iOS application built with **Clean Architecture**, **SwiftUI**, and **Swift Concurrency**, showcasing best practices in modularity and local persistence.

## 🚀 Features

- **Movie Discovery**: Fetches popular movies from a remote API.
- **Detailed View**: Rich movie details including poster, ratings, and overview.
- **Favorites System**: Save and remove movies from your local collection using Core Data.
- **Smart Navigation**: Implements the **Coordinator Pattern** for decoupled navigation logic.
- **Performance Optimized**: Uses `LazyVStack` and `AsyncImage` for smooth scrolling and efficient memory usage.

## 🏗 Architecture

The project follows **Clean Architecture** principles to ensure separation of concerns, testability, and maintainability.

### Layers:
1.  **Presentation**: SwiftUI Views, ViewModels, and Coordinators.
    - Uses the **Coordinator Pattern** to manage app flow.
    - ViewModels are isolated using `@MainActor`.
2.  **Domain**: Business logic and pure entities.
    - Contains `Interactors` and `Models`.
    - Completely independent of UI and Data frameworks.
3.  **Data**: Implementation of repositories and data sources.
    - **Remote**: Network fetching using `URLSession` and Swift Concurrency.
    - **Local**: Persistence layer using **Core Data** with an in-memory option for unit tests.
    - **Mappers**: Pure functions that transform DTOs/Entities into Domain models.

## 🛠 Technical Stack

- **SwiftUI**: Modern declarative UI.
- **Swift Concurrency**: `async/await` and `Actors` for safe, readable asynchronous code.
- **Core Data**: Robust local data persistence.
- **Swift Package Manager (SPM)**: Modularized project structure with a dedicated `CoreModules` package.
- **XCTest**: Comprehensive unit test suite for Interactors, Repositories, and the Core Data stack.

## 📦 Project Structure

```text
├── App/                # App entry point & configuration
├── Presentation/       # UI Layer (Views, Components, Coordinators)
└── Modules/
    └── CoreModules/    # Swift Package containing:
        ├── Domain/     # Business Logic & Interfaces
        └── Data/       # Core Data Stack, API Services, Repositories
```

## 🧪 Testing

The project maintains a high test coverage across all layers, utilizing both **XCTest** and the modern **Swift Testing** framework.

### Test Structure:
- **Presentation Tests**: Located in the `MyFavouriteMoviesTests/` directory of the main app target. These tests use **Swift Testing** to verify ViewModels and UI state logic.
- **Core Logic Tests**: Located within the `CoreModules` Swift Package. These cover Domain Interactors and Data Repositories using **XCTest**.

### Key Test Features:
- **Mocking Strategy**: Comprehensive mocks (e.g., `MockMovieInteractor`, `MockRepository`) ensure that each layer is tested in complete isolation.
- **In-Memory Core Data**: Persistence tests run against a volatile RAM database to ensure speed and isolation without polluting local storage.
- **Async Verification**: Robust testing of `async/await` flows and optimistic UI updates.

To run tests:
1. Open the project in Xcode.
2. Ensure the **MyFavouriteMovies** scheme is selected.
3. Press `Cmd + U` to run all tests across both the app target and internal modules.

## ⚙️ Configuration

The app requires a TMDB API key to fetch movie data.
1. Create a `ApiConstants.swift` file in the `App/` directory.
2. Add your API key:
```swift
struct ApiConstants {
    static let apiKey = "YOUR_API_KEY"
    static let baseURL = "https://api.themoviedb.org/3"
}
```

---
Developed with ❤️ using Swift 6.
