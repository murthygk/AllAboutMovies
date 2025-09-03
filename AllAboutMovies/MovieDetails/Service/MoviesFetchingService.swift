//
//  MoviesFetchingService.swift
//  AllAboutMovies
//
//  Created by Gudipati, Krishna on 9/3/25.
//

import Foundation

enum MoviesAPI {
    static let APIKey = "ee60b1cc"
    struct URL {
        static let mainPath = "https://www.omdbapi.com/"
        static let parameterAPIKey = "apiKey"
        static let searchByTitleParameterKey = "t"
    }
    struct Constants {
        // Numbers to be used if any
    }
}

protocol MoviesFetchingProvider {
    func fetchMovieData(with searchText: String) async throws -> MoviesFetchingState
}

struct MoviesFetchingService: MoviesFetchingProvider {
    func fetchMovieData(with searchText: String) async throws -> MoviesFetchingState {
        // example : https://www.omdbapi.com/?apiKey=ee60b1cc&t=abc
        let urlString = MoviesAPI.URL.mainPath
                        + "?"
                        + MoviesAPI.URL.parameterAPIKey
                        + "="
                        + MoviesAPI.APIKey
                        + "&"
                        + MoviesAPI.URL.searchByTitleParameterKey
                        + "="
                        + searchText

        //TODO: We can add a computed property or a func in enum MoviesAPI to build above URL like :
        //      func buildUrlForSearhByTitle(for searchText: String) -> String

        guard let url = URL(string: urlString) else {
            //TODO: A list of error strings can be enlisted as cases in an
            return .failure("Could not make out a valid URL")
        }

        do {
            //TODO: Wrap in do catch to capture error
            let (data, response) = try await URLSession.shared.data(from: url)
            let movieData = try JSONDecoder().decode(MovieDataDTO.self, from: data)
            return .success(movieData)
        }
        catch let error {
            /* guard let noData = try? JSONDecoder().decode(NoDataDTO.self, from: data) else {
             return .failure("Could not fetch any movie data with that search title")
             } */
                // return .failure(noData.errorMessage ?? "Error while fetching movie data")
            return .failure(error.localizedDescription)
        }
        /*
         //TODO: Wrap in do catch to capture error
         let (data, response) = try await URLSession.shared.data(from: url)

        if let movieData = try? JSONDecoder().decode(MovieDataDTO.self, from: data) {
            return .success(movieData)
        } else {
            guard let noData = try? JSONDecoder().decode(NoDataDTO.self, from: data) else {
                return .failure("Could not fetch any movie data with that search title")
            }
            return .failure(noData.errorMessage ?? "Error while fetching movie data")
        } */
    }
}
