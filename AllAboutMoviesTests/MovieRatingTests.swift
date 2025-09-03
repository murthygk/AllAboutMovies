//
//  MovieRatingTests.swift
//  AllAboutMoviesTests
//
//  Created by Gudipati, Krishna on 9/3/25.
//

import Testing
@testable import AllAboutMovies
import Foundation

struct MovieRatingTests {
    var modelSUT: MovieDataDTO!

    @Test("Testing rating ceil on rating")
    func testRatingWithCeiling() async throws {
        let movieJSON =
            """
                {
                    "Title": "Testing for Ceiling",
                    "Poster": "Nothing",
                    "imdbRating": "8.2"
                }
            """
        let modelSUT = try #require(try? JSONDecoder().decode(MovieDataDTO.self, from: Data(movieJSON.utf8)), "FAILED to decond test movie json")
        let expectedRating = 4 // (8.2 / 10) * 5 = 4.1 => 4
        #expect(modelSUT.rating == expectedRating)
    }

    @Test("Testing rating floor on rating")
    func testRatingWithFloor() async throws {
        let movieJSON =
            """
                {
                    "Title": "Testing for Ceiling",
                    "Poster": "Nothing",
                    "imdbRating": "9.9"
                }
            """
        let modelSUT = try #require(try? JSONDecoder().decode(MovieDataDTO.self, from: Data(movieJSON.utf8)), "FAILED to decond test movie json")
        let expectedRating = 5 // (9.7 / 10) * 5 = 4.85 => 5
        #expect(modelSUT.rating == expectedRating)
    }
}
