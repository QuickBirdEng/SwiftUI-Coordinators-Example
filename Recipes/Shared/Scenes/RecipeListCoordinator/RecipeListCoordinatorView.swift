//
//  RecipeListCoordinatorView.swift
//  Recipes
//
//  Created by Paul Kraft on 05.01.21.
//

import SwiftUI
import XUI

struct RecipeListCoordinatorView: View {

    // MARK: Stored Properties

    @Store var coordinator: RecipeListCoordinator

    // MARK: Views

    var body: some View {
        NavigationView {
            RecipeList(viewModel: coordinator.viewModel)
                .navigation(model: $coordinator.detailViewModel) { viewModel in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        phoneRecipeView(viewModel)
                    } else {
                        padRecipeView(viewModel)
                    }
                }
        }
    }

    @ViewBuilder
    private func phoneRecipeView(_ viewModel: RecipeViewModel) -> some View {
        RecipeView(
            viewModel: viewModel,
            ratingModifier: SheetModifier(model: $coordinator.ratingViewModel) { viewModel in
                NavigationView {
                    RatingView(viewModel: viewModel)
                }
            }
        )
    }

    @ViewBuilder
    private func padRecipeView(_ viewModel: RecipeViewModel) -> some View {
        RecipeView(
            viewModel: viewModel,
            ratingModifier: PopoverModifier(model: $coordinator.ratingViewModel) {
                RatingView(viewModel: $0)
                    .frame(width: 500, height: 500)
            }
        )
    }

}
