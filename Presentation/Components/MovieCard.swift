import SwiftUI

struct MovieCard: View {
    let movie: MovieUIData
    let onFavouriteToggle: () -> Void
    let onTap: () -> Void
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath)")){ phase in
                switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.gray)
                    case .empty:
                        ProgressView()
                    @unknown default:
                        Color.clear
                }
            }
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .clipped()

            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.headline)
                    .bold()
                    .lineLimit(1)

                Text(movie.overview)
                    .font(.subheadline)
                    .lineLimit(3)
            }
            .padding(12)
        }
        .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .contentShape(Rectangle()) // Essential for accurate hit-testing
        .onTapGesture(perform: onTap)
        .overlay(alignment: .topTrailing, content: {
            Button(action: onFavouriteToggle) {
                Image(systemName: movie.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .padding(8)
                    .background(.white.opacity(0.8))
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }
            .padding(8)
        })
    }
}
