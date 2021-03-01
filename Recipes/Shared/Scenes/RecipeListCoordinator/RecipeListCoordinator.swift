//
//  RecipeListCoordinator.swift
//  Recipes
//
//  Created by Paul Kraft on 05.01.21.
//

import SwiftUI
import XUI

protocol RecipeListCoordinator: ViewModel {
    var viewModel: RecipeListViewModel! { get }
    var detailViewModel: RecipeViewModel? { get set }
    var ratingViewModel: RatingViewModel? { get set }

    func filter(_ recipe: Recipe) -> Bool
    func open(_ recipe: Recipe)
    func openRatings(for recipe: Recipe)
    func closeRatings()
    func open(_ url: URL)
}

extension RecipeListCoordinator {

    @DeepLinkableBuilder
    var children: [DeepLinkable] {
        viewModel
        detailViewModel
        ratingViewModel
    }

}
