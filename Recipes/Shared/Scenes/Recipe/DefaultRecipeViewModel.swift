//
//  DefaultRecipeViewModel.swift
//  Recipes
//
//  Created by Paul Kraft on 07.01.21.
//

import Foundation

class DefaultRecipeViewModel: RecipeViewModel, ObservableObject, Identifiable {

    // MARK: Stored Properties

    @Published private(set) var recipe: Recipe

    private unowned let coordinator: RecipeListCoordinator

    // MARK: Initialization

    init(recipe: Recipe, coordinator: RecipeListCoordinator) {
        self.coordinator = coordinator
        self.recipe = recipe
    }

    // MARK: Methods

    func openRatings() {
        self.coordinator.openRatings(for: recipe)
    }

    func open(_ url: URL) {
        self.coordinator.open(url)
    }

}
