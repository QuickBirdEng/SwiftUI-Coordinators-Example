//
//  RatingViewModel.swift
//  Recipes
//
//  Created by Paul Kraft on 11.12.20.
//

import Foundation

class RatingViewModel: ObservableObject, Identifiable {

    // MARK: Stored Properties

    @Published var recipe: Recipe
    @Published var meanRating = 0.0
    @Published var ratings = [Recipe.Rating]()

    private let recipeService: RecipeService
    private unowned let coordinator: RecipeListCoordinator

    // MARK: Initialization

    init(recipe: Recipe, recipeService: RecipeService,
         coordinator: RecipeListCoordinator) {
        self.coordinator = coordinator
        self.recipe = recipe
        self.recipeService = recipeService

        recipeService.fetchRatings(for: recipe) { ratings in
            self.ratings = ratings
            self.meanRating = Double(ratings.map(\.value).reduce(0, +)) / Double(ratings.count)
        }
    }

    // MARK: Methods

    func close() {
        self.coordinator.closeRatings()
    }

}
