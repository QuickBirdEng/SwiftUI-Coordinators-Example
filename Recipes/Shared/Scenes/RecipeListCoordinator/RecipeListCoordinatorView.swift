//
//  RecipeListCoordinatorView.swift
//  Recipes
//
//  Created by Paul Kraft on 05.01.21.
//

import SwiftUI

struct RecipeListCoordinatorView: View {

    // MARK: Stored Properties

    @ObservedObject var coordinator: RecipeListCoordinator

    // MARK: Views

    var body: some View {
        NavigationView {
            RecipeList(viewModel: coordinator.viewModel)
                .navigation(item: $coordinator.detailViewModel) { viewModel in
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
            ratingModifier: SheetModifier(item: $coordinator.ratingViewModel) { viewModel in
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
            ratingModifier: PopoverModifier(item: $coordinator.ratingViewModel) {
                RatingView(viewModel: $0)
                    .frame(width: 500, height: 500)
            }
        )
    }

}
