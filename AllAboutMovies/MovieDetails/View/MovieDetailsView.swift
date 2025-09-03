//
//  MovieDetailsView.swift
//  AllAboutMovies
//
//  Created by Gudipati, Krishna on 9/3/25.
//

import SwiftUI

struct MovieDetailsView: View {
    @StateObject var viewModel: MovieDetailsViewModel
    var body: some View {
        NavigationStack {
           //TODO: Add scrollview if MovieDataDTO is fully fetchted and displayed here
            VStack {
                switch viewModel.moviesFetchDataState {
                    case .success(let movieData):
                        MovieView(
                            title: movieData.title,
                            posterImageUrl: movieData.posterUrl,
                            rating: movieData.rating
                        )
                    case .failure(let string):
                        Text(string)
                    case .noDataYet:
                        Text("No Data Yet")
                }
            }
            .navigationTitle("Movie Details")
        }
        .searchable(text: $viewModel.searchText, prompt: "Start searching movies by entering title")
        .onChange(of: viewModel.searchText) {
            Task {
                do {
                    try await viewModel.fetchMovieData(with: viewModel.searchText)
                } catch {
                    print("Error fetching data")
                }
            }
        }
    }
}

struct MovieView: View {
    var title: String
    var posterImageUrl: URL?
    var rating: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .padding()
            AsyncImage(url: posterImageUrl)
            HStack {
                ForEach(0..<rating, id: \.self) { starIndex in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
            .accessibilityLabel(Text("\(rating) out of 5"))
            .padding()
        }
    }
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailsViewModel(moviesFetchingService: nil))
}
