//
//  RatingViewModel.swift
//  Recipes
//
//  Created by Paul Kraft on 11.12.20.
//

import Foundation
import XUI

protocol RatingViewModel: ViewModel {
    var recipe: Recipe { get }
    var meanRating: Double { get }
    var ratings: [Recipe.Rating] { get }

    func close()
}
