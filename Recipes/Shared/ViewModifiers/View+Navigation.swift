//
//  View+Navigation.swift
//  Recipes
//
//  Created by Paul Kraft on 05.01.21.
//

import SwiftUI

extension View {

    /// Wraps `self` in a hidden `NavigationLink` whose activation fires `action`.
    /// Use when the tap should trigger an imperative side effect (typically a
    /// coordinator method) rather than navigate to a statically known destination.
    func onNavigation(_ action: @escaping () -> Void) -> some View {
        let isActive = Binding(
            get: { false },
            set: { newValue in
                if newValue {
                    action()
                }
            }
        )
        return NavigationLink(
            destination: EmptyView(),
            isActive: isActive
        ) {
            self
        }
    }

    /// Pushes `destination(item)` whenever `item` becomes non-nil; clearing
    /// `item` (e.g. when the user pops) is propagated back through the binding.
    /// Lets a coordinator drive navigation by mutating an optional `@Published`
    /// view model rather than embedding a hardcoded `NavigationLink` in the view.
    func navigation<Item, Destination: View>(
        item: Binding<Item?>,
        @ViewBuilder destination: (Item) -> Destination
    ) -> some View {
        let isActive = Binding(
            get: { item.wrappedValue != nil },
            set: { value in
                if !value {
                    item.wrappedValue = nil
                }
            }
        )
        return navigation(isActive: isActive) {
            item.wrappedValue.map(destination)
        }
    }

    /// Pushes `destination()` while `isActive` is true. The destination is
    /// constructed lazily — only when the link is active — and the link itself
    /// lives in an `overlay` so it doesn't disturb the receiver's layout.
    func navigation<Destination: View>(
        isActive: Binding<Bool>,
        @ViewBuilder destination: () -> Destination
    ) -> some View {
        overlay(
            NavigationLink(
                destination: isActive.wrappedValue ? destination() : nil,
                isActive: isActive,
                label: { EmptyView() }
            )
        )
    }

}

extension NavigationLink {

    /// Optional-item-driven `NavigationLink`: active iff `item` is non-nil,
    /// and pops by clearing the binding. Mirrors `sheet(item:content:)`
    /// for push-style navigation.
    init<T: Identifiable, D: View>(item: Binding<T?>,
                                   @ViewBuilder destination: (T) -> D,
                                   @ViewBuilder label: () -> Label) where Destination == D? {
        let isActive = Binding(
            get: { item.wrappedValue != nil },
            set: { value in
                if !value {
                    item.wrappedValue = nil
                }
            }
        )
        self.init(
            destination: item.wrappedValue.map(destination),
            isActive: isActive,
            label: label
        )
    }

}
