//
//  SettingsView.swift
//  Recipes
//
//  Created by Paul Kraft on 01.01.21.
//

import SwiftUI

struct SettingsView: View {

    // MARK: Stored Properties

    @ObservedObject var coordinator: HomeCoordinator

    // MARK: Views

    var body: some View {
        VStack(spacing: 8) {
            Text("QuickBird Studios GmbH").bold()
            Text("Nymphenburger Str. 13-15")
            Text("80335 Munich")
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .contentShape(Rectangle())
        .onTapGesture(perform: openWebsite)
        .navigationTitle("Settings")
    }

    // MARK: Methods

    private func openWebsite() {
        guard let url = URL(string: "https://quickbirdstudios.com/") else {
            return assertionFailure()
        }
        self.coordinator.open(url)
    }

}
