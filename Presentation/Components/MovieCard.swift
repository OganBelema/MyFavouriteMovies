import SwiftUI

struct MovieCard: View {
    let movie: MovieUIData
    let onFavouriteToggle: () -> Void
    let onTap: () -> Void
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(alignment: .leading) {
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
            .frame(maxHeight: 200)
            .clipped()
            
            Spacer()
            
            Text(movie.title)
                .font(.title)
                .padding(.horizontal, 8)
            
            Spacer()
            
            Text(movie.overview)
                .font(.body)
                .padding(.horizontal, 8)
            
            Spacer()
        }
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
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 5, x: 0, y: 2)
        .onTapGesture(perform: onTap)
    }
}
