//
//  RecipesApp.swift
//  Shared
//
//  Created by Paul Kraft on 11.12.20.
//

import SwiftUI

@main
struct RecipesApp: App {

    // MARK: Stored Properties

    let recipeService: RecipeService
    @StateObject var coordinator: DefaultHomeCoordinator
    @State var hasOpenedURL = false

    // MARK: Initialization

    init() {
        recipeService = RecipeService()
        let coordinator = DefaultHomeCoordinator(recipeService: recipeService)
        _coordinator = .init(wrappedValue: coordinator)
    }

    // MARK: Scenes

    var body: some Scene {
        WindowGroup {
            HomeCoordinatorView(coordinator: coordinator)
                .onOpenURL { coordinator.startDeepLink(from: $0) }
                .onAppear { simulateURLOpening() }
        }
    }

    // MARK: Helpers

    private func simulateURLOpening() {
        #if DEBUG
        guard !hasOpenedURL else {
            return
        }
        hasOpenedURL = true
        self.recipeService.fetchRecipes { recipes in
            guard let recipe = recipes.randomElement(),
                  let url = URL(string: "recipes://ratings?recipeID=" + recipe.id.uuidString) else {
                assertionFailure("Could not find recipe or illegal url format.")
                return
            }

            coordinator.startDeepLink(from: url)
        }
        #endif
    }

}
