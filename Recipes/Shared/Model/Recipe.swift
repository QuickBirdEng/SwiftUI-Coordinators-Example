//
//  Recipe.swift
//  Recipes
//
//  Created by Paul Kraft on 11.12.20.
//

import Foundation
import SwiftUI

struct Recipe: Identifiable {

    // MARK: Stored Properties

    var id = UUID()
    var imageURL: URL?
    var title: String
    var ingredients: [String]
    var steps: [String]
    var isVegetarian: Bool
    var source: URL?

}

extension Recipe {

    struct Rating: Identifiable {

        // MARK: Stored Properties

        var id = UUID()
        var author: String
        var value: Double
        var comment: String

    }

}
