//
//  HomeCoordinator.swift
//  Recipes
//
//  Created by Paul Kraft on 11.12.20.
//

import SwiftUI
import XUI

struct HomeCoordinatorView: View {

    // MARK: Stored Properties

    @Store var coordinator: HomeCoordinator

    // MARK: Views

    var body: some View {
        TabView(selection: $coordinator.tab) {

            RecipeListCoordinatorView(coordinator: coordinator.meatCoordinator)
            .tabItem { Label("Meat", systemImage: "hare.fill") }
            .tag(HomeTab.meat)

            RecipeListCoordinatorView(coordinator: coordinator.veggieCoordinator)
            .tabItem { Label("Veggie", systemImage: "leaf.fill") }
            .tag(HomeTab.veggie)

            NavigationView {
                SettingsView(coordinator: coordinator)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem { Label("Settings", systemImage: "gear") }
            .tag(HomeTab.settings)

        }
        .sheet(item: $coordinator.openedURL) {
            SafariView(url: $0)
                .edgesIgnoringSafeArea(.all)
        }
    }

}
