//
//  RatingView.swift
//  Recipes
//
//  Created by Paul Kraft on 11.12.20.
//

import Foundation
import SwiftUI

struct RatingView: View {

    // MARK: Nested Types

    struct Cell: View {

        let author: String
        let rating: Double
        let comment: String?

        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(author)
                    Spacer()
                    RatingStars(rating: rating)
                }

                if let comment = comment {
                    Text(comment)
                        .font(.body)
                }
            }
            .padding(.vertical, 8)
        }

    }

    // MARK: Stored Properties

    @ObservedObject var viewModel: RatingViewModel

    // MARK: Views

    var body: some View {
        List {
            HStack {
                Spacer()
                RatingStars(rating: viewModel.meanRating)
                Spacer()
            }
            .padding(.vertical, 8)

            ForEach(viewModel.ratings) { rating in
                Cell(author: rating.author,
                     rating: rating.value,
                     comment: rating.comment)
            }
        }
        .font(.headline)
        .navigationTitle(viewModel.recipe.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button("Close", action: viewModel.close))
    }

}
