//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Paul Kraft on 11.12.20.
//

import Foundation
import SwiftUI
import XUI

enum HomeTab {
    case meat
    case veggie
    case settings
}

protocol HomeCoordinator: ViewModel {
    var tab: HomeTab { get set }
    var veggieCoordinator: RecipeListCoordinator! { get }
    var meatCoordinator: RecipeListCoordinator! { get }
    var openedURL: URL? { get set }

    func startDeepLink(from url: URL)
    func open(_ url: URL)
}

extension HomeCoordinator {

    @DeepLinkableBuilder
    var children: [DeepLinkable] {
        veggieCoordinator
        meatCoordinator
    }

}
