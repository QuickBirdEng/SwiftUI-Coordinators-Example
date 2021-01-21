//
//  RecipeList.swift
//  Recipes
//
//  Created by Paul Kraft on 11.12.20.
//

import SwiftUI

struct RecipeList: View {

    // MARK: Stored Properties

    @ObservedObject var viewModel: RecipeListViewModel

    // MARK: Views

    var body: some View {
        List(viewModel.recipes) { recipe in
            HStack {
                AsyncImage(url: recipe.imageURL)
                    .frame(width: 40, height: 40)
                    .cornerRadius(10)
                Text(recipe.title)
                    .font(.headline)
                Spacer()
            }
            .onNavigation { viewModel.open(recipe) }
        }
        .navigationTitle(viewModel.title)
    }

}
