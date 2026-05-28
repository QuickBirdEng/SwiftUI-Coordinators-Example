//
//  SheetModifier.swift
//  Recipes
//
//  Created by Paul Kraft on 05.01.21.
//

import SwiftUI

/// Presents `content(item)` as a sheet whenever `item` is non-nil.
///
/// Exists as a `ViewModifier` so a coordinator can inject either this or
/// `PopoverModifier` into a leaf view, switching the presentation style
/// (e.g. by device or size class) without the leaf knowing about it.
struct SheetModifier<Item: Identifiable, Destination: View>: ViewModifier {

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
        content.sheet(item: item, content: destination)
    }

}
