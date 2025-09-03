//
//  ContentView.swift
//  AllAboutMovies
//
//  Created by Gudipati, Krishna on 9/3/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MovieDetailsView(
            viewModel: MovieDetailsViewModel(
                moviesFetchingService: MoviesFetchingService()
            )
        )
    }
}

#Preview {
    ContentView()
}
