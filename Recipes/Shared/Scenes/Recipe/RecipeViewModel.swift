//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by Paul Kraft on 11.12.20.
//

import Foundation
import XUI

protocol RecipeViewModel: ViewModel {
    var recipe: Recipe { get }

    func openRatings()
    func open(_ url: URL)
}
