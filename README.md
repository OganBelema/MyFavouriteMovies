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
- **XCTest & Swift Testing**: Comprehensive unit test suite for all layers.
- **Swift Snapshot Testing**: Visual regression testing for SwiftUI components and views.

## 📦 Project Structure

```text
├── App/                # App entry point & configuration
├── Presentation/       # UI Layer (Views, Components, Coordinators)
├── MyFavouriteMoviesTests/ # App-level tests (ViewModels & Snapshots)
└── Modules/
    └── CoreModules/    # Swift Package containing:
        ├── Domain/     # Business Logic & Interfaces
        └── Data/       # Core Data Stack, API Services, Repositories
```

## 🧪 Testing

The project maintains high test coverage across all layers, ensuring both functional correctness and visual consistency.

### Test Structure:
- **Unit Tests (Swift Testing)**: Located in `MyFavouriteMoviesTests/`. Verifies ViewModels, state transitions, and business logic.
- **Snapshot Tests (XCTest)**: Located in `MyFavouriteMoviesTests/`. Uses [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing) to prevent visual regressions in UI components.
- **Core Logic Tests (XCTest)**: Located in `Modules/CoreModules/Tests/`. Covers Domain Interactors and Data Repositories.

### Key Test Features:
- **Visual Regression**: Snapshots are taken for key UI components (like `MovieCard`) and full screens in both **Light** and **Dark** modes.
- **Mocking Strategy**: Comprehensive mocks ensure that each layer is tested in isolation.
- **In-Memory Core Data**: Persistence tests run against a volatile RAM database for speed and isolation.

To run tests:
1. Open the project in Xcode.
2. Ensure the **MyFavouriteMovies** scheme is selected.
3. Press `Cmd + U` to run all tests, including unit and snapshot tests.

> **Note**: Snapshot reference images are stored in `__Snapshots__` directories and should be committed to version control.

## 🤖 Gemini CLI Integration

This project is optimized for AI-assisted development using **Gemini CLI**. It includes project-specific configurations and context to help AI agents understand the architecture and coding standards.

### Features:
- **Project Context**: Optimized directory structure and naming conventions for better AI indexing.
- **MCP Tools**: Integrates with `xcode-tools` via MCP (Model Context Protocol) for autonomous building, testing, and UI rendering.
- **Automated Workflows**: Ready for AI-driven refactoring, documentation updates, and test generation.

### Using Gemini CLI:
If you have Gemini CLI installed, you can use it to perform complex tasks:
```bash
# Example commands
gemini "Refactor MovieViewModel to use Swift Testing"
gemini "Add snapshot tests for the MovieDetailView"
gemini "Audit the project for architectural inconsistencies"
```

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
