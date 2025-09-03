//
//  NoDataDTO.swift
//  AllAboutMovies
//
//  Created by Gudipati, Krishna on 9/3/25.
//

import Foundation

struct NoDataDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case error = "Error"
    }
    private let response: String?
    private let error: String?
}

extension NoDataDTO {
    var errorMessage: String? {
        return error
    }
}
