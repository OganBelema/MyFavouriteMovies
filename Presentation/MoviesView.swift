//
//  MoviesView.swift
//  MyFavouriteMovies
//
//  Created by Belema on 30/04/2026.
//

import Domain
import SwiftUI

struct MoviesView: View {
    @ObservedObject var viewModel: MovieViewModel
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var coordinator: MovieCoordinator

    var body: some View {
        Group {
            switch viewModel.uiState {
                case .nothing:
                    Color.clear
                case .loading:
                    ProgressView()
                case .loaded(let movies):
                    ScrollView {
                        ForEach(movies, id: \.id) { movie in
                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath)")){ phase in
                                    switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        case .failure:
                                            Image(systemName: "photo") // Fallback image
                                                .foregroundColor(.gray)
                                        case .empty:
                                            ProgressView() // Shows while loading
                                        @unknown default:
                                            EmptyView()
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
                                Button {
                                    viewModel.setFavourite(movieId: movie.id)
                                } label: {
                                    Image(systemName: movie.isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(.red)
                                        .padding(8)
                                        .background(.white.opacity(0.8))
                                        .clipShape(Circle())
                                        .shadow(radius: 3)
                                }
                                .padding(8) // Offset from the very edge
                            })
                            .background(colorScheme == .dark ? Color.black : Color.white)
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 5, x: 0, y: 2)
                            .padding()
                            .onTapGesture {
                                coordinator.push(.detail(movie))
                            }
                        }
                    }
                case .error(_):
                    EmptyView()
            }
        }
        .navigationTitle("Movies")
        .task {
            await viewModel.loadMovies()
        }
    }
}
