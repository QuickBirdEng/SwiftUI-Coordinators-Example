//
//  SheetModifier.swift
//  Recipes
//
//  Created by Paul Kraft on 05.01.21.
//

import SwiftUI

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
