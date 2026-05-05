import SwiftUI
import Combine
import Domain
import Data

enum MoviePage: Hashable {
    case movieList
    case detail(MovieUIData)
}

protocol MovieCoordinatorProtocol {
    var path: NavigationPath { get set }
    func push(_ page: MoviePage)
    func pop()
    func popToRoot()
}

@MainActor
class MovieCoordinator: MovieCoordinatorProtocol, ObservableObject {
    @Published var path = NavigationPath()
    private let moviesViewModel: MovieViewModel

    init() {
        self.moviesViewModel = Self.buildMoviesViewModel()
    }

    // MARK: - Navigation Methods
    func push(_ page: MoviePage) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    // MARK: - View Factory
    @ViewBuilder
    func build(_ page: MoviePage) -> some View {
        switch page {
        case .movieList:
            MoviesView(viewModel: moviesViewModel)
        case .detail(let movie):
            MovieDetailView(movie: movie)
        }
    }

    // MARK: - Composition Root
    private static func buildMoviesViewModel() -> MovieViewModel {
        let networkService = NetworkService(
            config: APIConfig(
                baseURL: ApiConstants.baseURL,
                apiKey: ApiConstants.apiKey
            )
        )
        let movieService = MovieService(networkService: networkService)
        let repository = MovieRepository(
            movieService: movieService,
            coreDataStack: CoreDataStack.shared,
            movieDTOMapper: MovieDTOMapper(),
            movieMapper: MovieMapper(),
            movieEntityMapper: MovieEntityMapper(),
            favoriteMovieMapper: FavouriteMovieMapper()
        )
        let interactor = MovieInteractor(repository: repository)
        return MovieViewModel(movieInteractor: interactor)
    }
}
