//
//  RecipeService.swift
//  Recipes
//
//  Created by Paul Kraft on 11.12.20.
//

import Foundation
import SwiftUI

class RecipeService {

    // MARK: Stored Properties - Recipes

    private let orangeMarmalade = Recipe(
        imageURL: URL(string: "https://publicdomainrecipes.org/recipes/orange-marmalade/Orange%20Marmalade_hu0aa2f9bacaf3459fa40fd69ec9d06da6_94464_350x350_fill_q75_box_smart1.jpg"),
        title: "Orange Marmalade",
        ingredients: ["12 oranges", "6 lemons", "1 gallon water", "10 pound sugar"],
        steps: [
            "Clean fruit with stiff brush and wipe dry; cut crosswise in very thin slices, reject the ends, pick out the seeds.",
            "Pour the water over the fruit and let stand 36 hours.",
            "Then put in preserving kettle and let cook slowly 2 hours.",
            "Then add sugar and cook 1 hour or until the mixture jellies."
        ],
        isVegetarian: true,
        source: URL(string: "https://publicdomainrecipes.org/recipes/orange-marmalade/")
    )

    private let mushroomsInCream = Recipe(
        imageURL: URL(string: "https://publicdomainrecipes.org/recipes/mushrooms-in-cream/Mushrooms%20in%20Cream_hu46031e1ef57493efe9e56c814b513ee6_41786_350x350_fill_q75_box_smart1.jpg"),
        title: "Mushrooms in Cream",
        ingredients: [
            "1/2 pound mushrooms",
            "3 tablespoon butter",
            "salt",
            "pepper",
            "flour",
            "3/4 cup cream",
            "toast"
        ],
        steps: [
            "Wash mushrooms; remove stems, and peel caps, and cut in pieces; melt butter and cook until tender; sprinkle with salt and pepper; dredge with flour and add cream.",
            "Let cook until heated thoroughly, then pour on pieces of toast and garnish with toast points."
        ],
        isVegetarian: true,
        source: URL(string: "https://publicdomainrecipes.org/recipes/mushrooms-in-cream/")
    )

    private let roastedWildDuck = Recipe(
        imageURL: URL(string: "https://publicdomainrecipes.org/recipes/roasted-wild-duck/Roasted%20Wild%20Duck_hu004b736d43b2db0e2f8c86e13334b46b_78997_350x350_fill_q75_box_smart1.jpg"),
        title: "Roasted Wild Duck",
        ingredients: [
            "duck",
            "alcohol",
            "soda water",
            "onion",
            "sage",
            "celery salt",
            "bacon",
            "pepper",
            "flour"
        ],
        steps: [
            "Take a plump, young duck; rub all over with alcohol and then hold over the burner to singe; wash thoroughly with soda water; then boil in soda water or water in which there is a little onion for 10 minutes before stuffing; then rinse in clear water and wipe dry; stuff with dressing, to which has been added a little onion, sage, celery salt or bacon chopped fine; sprinkle with pepper and salt and dredge with flour; place pieces of bacon over it.",
            "Roast under the flame until tender, turning and basting frequently with the tried out fat."
        ],
        isVegetarian: false,
        source: URL(string: "https://publicdomainrecipes.org/recipes/roasted-wild-duck/")
    )

    private let roastLamb = Recipe(
        imageURL: URL(string: "https://publicdomainrecipes.org/recipes/roast-lamb-with-banana-croquettes/Roast%20Lamb%20with%20Banana%20Croquettes_hu877c9bedf9d18b9a490347620c64b440_55965_350x350_fill_q75_box_smart1.jpg"),
        title: "Roast Lamb with Banana Croquettes",
        ingredients: [
            "lamb",
            "salt",
            "pepper",
            "flour",
            "bacon",
            "water",
            "parsley",
            "bananas",
            "lemon juice",
            "egg",
            "bread crumbs",
            "powdered sugar"
        ],
        steps: [
            "Remove the superfluous fat from a leg of lamb and score the thin layer of fat on the outer side of the leg diagonally; rub over with salt and pepper; dredge with flour, and set on the rack in the baking pan.",
            "Have the oven very hot at first, to sear over the outside; after 15 minutes reduce the heat and let cook about 2 hours; baste frequently with bacon fat melted in hot water.",
            "Remove to a serving dish; slip a paper frill over the bone, and garnish with parsley and banana croquettes.",
            "Remove the skin and coarse threads from the bananas and trim the pulp of each to a cylinder-shape croquette; coat each with lemon juice to keep from discoloring; then roll in egg and then in sifted bread crumbs; fry in deep fat, and dust with powdered sugar."
        ],
        isVegetarian: false,
        source: URL(string: "https://publicdomainrecipes.org/recipes/roast-lamb-with-banana-croquettes/")
    )

    // MARK: Stored Properties - Ratings

    private let angryRating = Recipe.Rating(
        author: "Jupiter Jones",
        value: .random(in: 0...0.3),
        comment: "One word: Disgusting."
    )

    private let mediumRating = Recipe.Rating(
        author: "Peter Crenshaw",
        value: .random(in: 0.3...0.7),
        comment: "Well, it was alright..."
    )

    private let happyRating = Recipe.Rating(
        author: "Robert Andrews",
        value: .random(in: 0.7...1),
        comment: "Best. Dish. Ever."
    )

    // MARK: Methods

    func fetchRecipes(_ completion: @escaping ([Recipe]) -> Void) {
        completion(
            Mirror(reflecting: self)
                .children
                .compactMap { $0.value as? Recipe }
                .sorted(by: { $0.title < $1.title })
        )
    }



    func fetchRatings(for recipe: Recipe,
                      _ completion: @escaping ([Recipe.Rating]) -> Void) {
        completion(
            Mirror(reflecting: self)
                .children
                .compactMap { $0.value as? Recipe.Rating }
                .shuffled()
        )
    }

}
