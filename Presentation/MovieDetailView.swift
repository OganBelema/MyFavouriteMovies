import SwiftUI

struct MovieDetailView: View {
    let movie: MovieUIData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath)")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .cornerRadius(12)
                
                Text(movie.title)
                    .font(.largeTitle)
                    .bold()
                
                HStack {
                    Image(systemName: "calendar")
                    Text(movie.releaseDate)
                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", movie.voteAverage))
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Text("Overview")
                    .font(.headline)
                
                Text(movie.overview)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
