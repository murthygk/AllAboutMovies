//
//  MoviewViewModelTests.swift
//  AllAboutMoviesTests
//
//  Created by Gudipati, Krishna on 9/3/25.
//

import Testing
import Foundation

@testable import AllAboutMovies

struct MoviewViewModelTests {

    @Test("To test movie data found")
    func testMovieDataFound() async throws {

            //GIVEN
        let mockMovieFetchService = MockFetchService()
        let viewDataModelSUT = MovieDetailsViewModel(
            moviesFetchingService: mockMovieFetchService
        )

            //WHEN
        mockMovieFetchService.setMovieDataResponse()
        try await viewDataModelSUT.fetchMovieData(with: "somevalidname")

            //THEN
        if case .success = viewDataModelSUT.moviesFetchDataState {
            #expect(true)
        } else {
            #expect(Bool(false))
        }
    }

    @Test("To test movie data found")
    func testMovieDataNotFound() async throws {
            //GIVEN
        let mockMovieFetchService = MockFetchService()
        let viewDataModelSUT = MovieDetailsViewModel(
            moviesFetchingService: mockMovieFetchService
        )

            //WHEN
        mockMovieFetchService.setNoDataResponse()
        try await viewDataModelSUT.fetchMovieData(with: "assumenovalidname")

            //THEN
        if case .failure = viewDataModelSUT.moviesFetchDataState {
            #expect(true)
        } else {
            #expect(Bool(false))
        }
    }
}

class MockFetchService: MoviesFetchingProvider {

    var movieState: MoviesFetchingState = .noDataYet

    func fetchMovieData(with searchText: String) async throws -> AllAboutMovies.MoviesFetchingState {
        return movieState
    }

    func setNoDataResponse() {
        let movieJSON =
            """
                {
                  "Response": "False",
                  "Error":"Movie not found!"
                }
              """
        guard let modelSUT = try? JSONDecoder().decode(NoDataDTO.self, from: Data(movieJSON.utf8)) else {
            fatalError("How can I test if it failed decoding NoDataDTO")
        }
        self.movieState = .failure(modelSUT.errorMessage ?? "No Data")
    }

    func setMovieDataResponse() {
        let movieJSON =
            """
                {
                    "Title": "Testing for Ceiling",
                    "Poster": "Nothing",
                    "imdbRating": "9.9"
                }
            """
        guard let modelSUT = try? JSONDecoder().decode(MovieDataDTO.self, from: Data(movieJSON.utf8)) else {
            fatalError("How can I test if it failed decoding MovieDataDTO")
        }
        self.movieState = .success(modelSUT)
    }
}

extension MoviesFetchingState: Equatable {
    public static func ==(lhs: MoviesFetchingState, rhs: MoviesFetchingState) -> Bool {
        switch (lhs, rhs) {
            case (.success, .success) : return true
            case (.failure, .failure) : return true
            default: return false
        }
    }
}
