//
//  MovieDetailsViewModel.swift
//  AllAboutMovies
//
//  Created by Gudipati, Krishna on 9/3/25.
//

import Foundation
import Combine

enum MoviesFetchingState {
    case success(MovieDataDTO)
    case failure(String)
    case noDataYet
}

final class MovieDetailsViewModel: ObservableObject {
    private let moviesFetchingService: MoviesFetchingProvider?
    @Published var moviesFetchDataState: MoviesFetchingState = .noDataYet
    @Published var searchText: String = ""

    init(moviesFetchingService: MoviesFetchingProvider?) {
        self.moviesFetchingService = moviesFetchingService
    }

    func fetchMovieData(with searchText: String) async throws {
        guard let moviesFetchingService else {
            self.moviesFetchDataState = .noDataYet
            return
        }
        //TODO: MoviesFetchign on background
        self.moviesFetchDataState = try await moviesFetchingService.fetchMovieData(with: searchText)
    }
}
