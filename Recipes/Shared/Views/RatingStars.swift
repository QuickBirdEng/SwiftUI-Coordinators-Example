//
//  RatingStars.swift
//  Recipes
//
//  Created by Paul Kraft on 02.01.21.
//

import SwiftUI

struct RatingStars: View {

    // MARK: Stored Properties

    let rating: Double

    // MARK: Views

    var body: some View {
        HStack(spacing: 0) {
            star(range: 0.09...0.18)
            star(range: 0.27...0.36)
            star(range: 0.45...0.54)
            star(range: 0.63...0.72)
            star(range: 0.81...0.90)
        }
    }

    private func star(range: ClosedRange<Double>) -> some View {
        if range.contains(rating) {
            return Image(systemName: "star.leadinghalf.fill")
        } else if rating > range.upperBound {
            return Image(systemName: "star.fill")
        } else {
            return Image(systemName: "star")
        }
    }

}
