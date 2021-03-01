//
//  DefaultHomeCoordinator.swift
//  Recipes
//
//  Created by Paul Kraft on 07.01.21.
//

import Foundation
import XUI

class DefaultHomeCoordinator: ObservableObject, HomeCoordinator {

    // MARK: Stored Properties

    @Published var tab = HomeTab.meat
    @Published private(set) var veggieCoordinator: RecipeListCoordinator!
    @Published private(set) var meatCoordinator: RecipeListCoordinator!
    @Published var openedURL: URL?

    private let recipeService: RecipeService

    // MARK: Initialization

    init(recipeService: RecipeService) {
        self.recipeService = recipeService

        self.veggieCoordinator = DefaultRecipeListCoordinator(
            title: "Veggie",
            recipeService: recipeService,
            parent: self,
            filter: { $0.isVegetarian }
        )

        self.meatCoordinator = DefaultRecipeListCoordinator(
            title: "Meat",
            recipeService: recipeService,
            parent: self,
            filter: { !$0.isVegetarian }
        )
    }

    // MARK: Methods

    func startDeepLink(from url: URL) {
        guard url.scheme == "recipes",
              url.host == "ratings",
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let recipeID = components.queryItems?.first(where: { $0.name == "recipeID" })?.value else {
            assertionFailure("Trying to open app with illegal url \(url).")
            return
        }

        openRatingsForRecipe(id: recipeID)
    }

    func open(_ url: URL) {
        self.openedURL = url
    }

    // MARK: Helpers

    private func openRatings(for recipe: Recipe) {
        tab = recipe.isVegetarian ? .veggie : .meat
        let recipeListCoordinator = firstReceiver(as: RecipeListCoordinator.self, where: { $0.filter(recipe) })
        recipeListCoordinator!.open(recipe)
        let recipeViewModel = firstReceiver(as: RecipeViewModel.self, where: { $0.recipe.id == recipe.id })
        recipeViewModel!.openRatings()
    }

    private func openRatingsForRecipe(id: String) {
        recipeService.fetchRecipe(id: id) { [weak self] recipe in
            guard let recipe = recipe, let self = self else {
                return
            }

            self.openRatings(for: recipe)
        }
    }

}
