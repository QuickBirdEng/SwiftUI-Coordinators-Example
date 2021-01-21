//
//  AsyncImage.swift
//  Recipes
//
//  Created by Paul Kraft on 04.03.20.
//

import Combine
import SwiftUI

struct AsyncImage<V: View>: View {

    // MARK: Stored Properties

    let `default`: V
    let url: URL?

    @State private var requestOngoing = false
    @State private var image: Image? = nil
    @State private var cancellables = Set<AnyCancellable>()

    // MARK: Views

    var body: some View {
        content
            .onAppear(perform: reload)
            .onChange(of: url) { _ in
                self.cancellables.removeAll()
                self.image = nil
            }
            .onChange(of: image) { _ in reload() }
    }

    @ViewBuilder
    private var content: some View {
        if let image = image {
            image
                .resizable()
                .scaledToFill()
        } else {
            `default`
        }
    }

    // MARK: Helpers

    private func request() -> AnyPublisher<Image, Never> {
        guard let url = url else {
            return Empty()
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .compactMap { UIImage(data: $0.data).map(Image.init) }
            .catch { _ in Empty() }
            .eraseToAnyPublisher()
    }

    private func reload() {
        guard image == nil, !requestOngoing else {
            return
        }
        requestOngoing = true
        request()
            .map(Optional.some)
            .handleEvents(
                receiveCompletion: { _ in
                    self.requestOngoing = false
                },
                receiveCancel: {
                    self.requestOngoing = false
                }
            )
            .assign(to: \.image, on: self)
            .store(in: &cancellables)
    }

}

extension AsyncImage where V == Color {

    init(url: URL?) {
        self.init(default: .gray, url: url)
    }

}
