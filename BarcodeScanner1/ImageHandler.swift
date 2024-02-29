//
//  ImageHandler.swift
//  BarcodeScanner1
//
//  Created by Fernando Sensenhauser on 29/02/24.
//

import Foundation
import SwiftUI
import Combine
class ImageCache {
    static let shared = ImageCache()
    private var cache = NSCache<NSString, UIImage>()
    
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            return Just(image).eraseToAnyPublisher()
        } else {
            return URLSession.shared.dataTaskPublisher(for: url)
                .map { UIImage(data: $0.data) }
                .replaceError(with: nil)
                .handleEvents(receiveOutput: { [weak self] image in
                    if let image = image {
                        self?.cache.setObject(image, forKey: url.absoluteString as NSString)
                    }
                })
                .eraseToAnyPublisher()
        }
    }
}

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var imageLoader: ImageLoader
    private let placeholder: Placeholder
    
    init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholder
            }
        }
        .onAppear {
            imageLoader.loadImage()
        }
    }
}

class ImageLoader: ObservableObject {
    private var cancellable: AnyCancellable?
    let url: URL
    @Published var image: UIImage?
    
    init(url: URL) {
        self.url = url
    }
    
    func loadImage() {
        cancellable = ImageCache.shared.loadImage(from: url)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loadedImage in
                self?.image = loadedImage
            }
    }
}
