//
//  RecipeView.swift
//  Recipes
//
//  Created by Paul Kraft on 11.12.20.
//

import SwiftUI

struct RecipeView<RatingModifier: ViewModifier>: View {

    // MARK: Stored Properties

    @ObservedObject var viewModel: RecipeViewModel
    let ratingModifier: RatingModifier

    // MARK: Views

    var body: some View {
        List {
            if viewModel.recipe.imageURL != nil {
                AsyncImage(url: viewModel.recipe.imageURL)
                    .frame(maxHeight: UIScreen.main.bounds.height / 3)
                    .clipped()
                    .listRowInsets(.init())
                    .overlay(sourceOverlay, alignment: .bottom)
            }

            Section(header: Text("Ingredients")) {
                ForEach(viewModel.recipe.ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
            }

            Section(header: Text("Directions")) {
                ForEach(viewModel.recipe.steps, id: \.self) { step in
                    Text(step)
                }
            }
        }
        .navigationBarItems(trailing: ratingsButton)
        .navigationTitle(Text(viewModel.recipe.title))
    }

    @ViewBuilder
    private var ratingsButton: some View {
        Button(action: viewModel.openRatings) {
            Image(systemName: "person.3.fill")
        }
        .modifier(ratingModifier)
    }

    @ViewBuilder
    private var sourceOverlay: some View {
        if let source = viewModel.recipe.source {
            HStack {
                Image(systemName: "safari")
                Text("Source")
                Spacer()
            }
            .font(.headline)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(Color(.systemBackground).opacity(0.75))
            .onTapGesture { viewModel.open(source) }
        }
    }

}
