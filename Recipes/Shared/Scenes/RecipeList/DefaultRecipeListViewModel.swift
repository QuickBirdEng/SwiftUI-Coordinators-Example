//
//  DefaultRecipeListViewModel.swift
//  Recipes
//
//  Created by Paul Kraft on 07.01.21.
//

import Combine
import Foundation

class DefaultRecipeListViewModel: ObservableObject, RecipeListViewModel {

    // MARK: Stored Properties

    @Published private(set) var title: String
    @Published private(set) var recipes = [Recipe]()

    private let recipeService: RecipeService
    private var cancellables = Set<AnyCancellable>()
    private unowned let coordinator: RecipeListCoordinator

    // MARK: Initialization

    init(title: String,
         recipeService: RecipeService,
         coordinator: RecipeListCoordinator,
         filter: @escaping (Recipe) -> Bool) {

        self.title = title
        self.coordinator = coordinator
        self.recipeService = recipeService

        coordinator
            .objectWillChange
            .sink(receiveValue: objectWillChange.send)
            .store(in: &cancellables)

        recipeService.fetchRecipes {
            self.recipes = $0.filter(filter)
        }

    }

    // MARK: Methods

    func open(_ recipe: Recipe) {
        coordinator.open(recipe)
    }

}
