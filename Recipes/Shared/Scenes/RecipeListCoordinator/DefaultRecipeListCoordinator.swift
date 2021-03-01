//
//  DefaultRecipeListCoordinator.swift
//  Recipes
//
//  Created by Paul Kraft on 07.01.21.
//

import Foundation
import XUI

class DefaultRecipeListCoordinator: ObservableObject, RecipeListCoordinator, Identifiable {

    // MARK: Stored Properties

    @Published private(set) var viewModel: RecipeListViewModel!
    @Published var detailViewModel: RecipeViewModel?
    @Published var ratingViewModel: RatingViewModel?

    private let _filter: (Recipe) -> Bool
    private let recipeService: RecipeService
    private unowned let parent: HomeCoordinator

    // MARK: Initialization

    init(title: String,
         recipeService: RecipeService,
         parent: HomeCoordinator,
         filter: @escaping (Recipe) -> Bool) {
        self.parent = parent
        self.recipeService = recipeService
        self._filter = filter

        self.viewModel = DefaultRecipeListViewModel(
            title: title,
            recipeService: recipeService,
            coordinator: self,
            filter: filter
        )
    }

    // MARK: Methods

    func filter(_ recipe: Recipe) -> Bool {
        _filter(recipe)
    }

    func open(_ recipe: Recipe) {
        detailViewModel = DefaultRecipeViewModel(recipe: recipe, coordinator: self)
    }

    func openRatings(for recipe: Recipe) {
        ratingViewModel = DefaultRatingViewModel(recipe: recipe, recipeService: recipeService, coordinator: self)
    }

    func closeRatings() {
        ratingViewModel = nil
    }

    func open(_ url: URL) {
        parent.open(url)
    }

}
