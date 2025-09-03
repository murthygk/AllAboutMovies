//
//  MovieDataDTO.swift
//  AllAboutMovies
//
//  Created by Gudipati, Krishna on 9/3/25.
//

import Foundation

struct MovieDataDTO: Decodable {
    //TODO: CodeImprovement: We can use enum CodingKeys to map JSON names to camelcase which is a standard practice of naming properties.
    private let Title: String?
    private let Poster: String?
    private let imdbRating: String?
}

extension MovieDataDTO {
    var rating: Int {
        guard let imdbRatingString = imdbRating,
              let movieRating = Float(imdbRatingString) else {
            return 0
        }
        //TODO: Move numbers in to common place/struct/enum as static constants
        let rating = (movieRating / 10.0) * 5
        return Int(rating.rounded(.toNearestOrAwayFromZero))
    }

    var title: String {
        return Title ?? "No movie data received from IMDB"
    }

    var posterUrl: URL? {
        guard let Poster else {
            return nil
        }
        return URL(string: Poster)
    }
}
