//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Paul Kraft on 11.12.20.
//

import Foundation
import SwiftUI

enum HomeTab {
    case meat
    case veggie
    case settings
}

class HomeCoordinator: ObservableObject {

    // MARK: Stored Properties

    @Published var tab = HomeTab.meat
    @Published var veggieCoordinator: RecipeListCoordinator!
    @Published var meatCoordinator: RecipeListCoordinator!

    @Published var openedURL: URL?

    private let recipeService: RecipeService

    // MARK: Initialization

    init(recipeService: RecipeService) {
        self.recipeService = recipeService

        self.veggieCoordinator = .init(
            title: "Veggie",
            recipeService: recipeService,
            parent: self,
            filter: { $0.isVegetarian }
        )

        self.meatCoordinator = .init(
            title: "Meat",
            recipeService: recipeService,
            parent: self,
            filter: { !$0.isVegetarian }
        )
    }

    // MARK: Methods

    func open(_ url: URL) {
        self.openedURL = url
    }

}
