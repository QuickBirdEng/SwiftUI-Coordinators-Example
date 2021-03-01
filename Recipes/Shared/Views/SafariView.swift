//
//  SafariView.swift
//  Recipes (iOS)
//
//  Created by Paul Kraft on 04.01.21.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {

    // MARK: Stored Properties

    let url: URL

    // MARK: Methods

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let configuration = SFSafariViewController.Configuration()
        configuration.barCollapsingEnabled = false
        return SFSafariViewController(url: url, configuration: configuration)
    }

    func updateUIViewController(_ controller: SFSafariViewController, context: Context) {

    }

}

extension View {

    func safariSheet(with binding: Binding<URL?>) -> some View {
        sheet(item: binding) { url in
            SafariView(url: url)
                .edgesIgnoringSafeArea(.all)
        }
    }

}
