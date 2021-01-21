//
//  RecipeListCoordinator.swift
//  Recipes
//
//  Created by Paul Kraft on 05.01.21.
//

import SwiftUI

class RecipeListCoordinator: ObservableObject, Identifiable {

    // MARK: Stored Properties

    @Published var viewModel: RecipeListViewModel!
    @Published var detailViewModel: RecipeViewModel?
    @Published var ratingViewModel: RatingViewModel?

    private let recipeService: RecipeService
    private unowned let parent: HomeCoordinator

    // MARK: Initialization

    init(title: String,
         recipeService: RecipeService,
         parent: HomeCoordinator,
         filter: @escaping (Recipe) -> Bool) {
        self.parent = parent
        self.recipeService = recipeService

        self.viewModel = .init(
            title: title,
            recipeService: recipeService,
            coordinator: self,
            filter: filter
        )
    }

    // MARK: Methods

    func open(_ recipe: Recipe) {
        self.detailViewModel = .init(recipe: recipe, coordinator: self)
    }

    func openRatings(for recipe: Recipe) {
        self.ratingViewModel = .init(recipe: recipe, recipeService: recipeService, coordinator: self)
    }

    func closeRatings() {
        self.ratingViewModel = nil
    }

    func open(_ url: URL) {
        self.parent.open(url)
    }

}
