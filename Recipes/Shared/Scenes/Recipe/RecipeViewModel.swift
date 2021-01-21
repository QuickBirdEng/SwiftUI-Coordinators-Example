//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by Paul Kraft on 11.12.20.
//

import Foundation

class RecipeViewModel: ObservableObject, Identifiable {

    // MARK: Stored Properties

    @Published var recipe: Recipe

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
