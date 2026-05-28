//
//  PopoverModifier.swift
//  Recipes
//
//  Created by Paul Kraft on 05.01.21.
//

import SwiftUI

/// Presents `content(item)` as a popover whenever `item` is non-nil.
/// Pair with `SheetModifier` to let a coordinator pick the presentation
/// style for a leaf view based on device or size class.
struct PopoverModifier<Item: Identifiable, Destination: View>: ViewModifier {

    // MARK: Stored Properties

    private let item: Binding<Item?>
    private let destination: (Item) -> Destination

    // MARK: Initialization

    init(item: Binding<Item?>,
         @ViewBuilder content: @escaping (Item) -> Destination) {

        self.item = item
        self.destination = content
    }

    // MARK: Methods

    func body(content: Content) -> some View {
        content.popover(item: item, content: destination)
    }

}
