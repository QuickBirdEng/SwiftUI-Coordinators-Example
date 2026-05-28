//
//  URL+Identifiable.swift
//  Recipes
//
//  Created by Paul Kraft on 05.01.21.
//

import Foundation

extension URL: @retroactive Identifiable {

    public var id: String {
        absoluteString
    }

}
