//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by Paul Kraft on 11.12.20.
//

import SwiftUI
import XUI

protocol RecipeListViewModel: ViewModel {
    var title: String { get }
    var recipes: [Recipe] { get }

    func open(_ recipe: Recipe)
}
