//
//  NJImageLoader.swift
//  FacebookApp
//
//  Created by joehsieh on 2022/01/06.
//  Copyright © 2022 NJ. All rights reserved.
//

import Combine
import UIKit

final class NJImageLoader {
    
    private let imageCache = NJImageCache(
    )
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = imageCache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, _) -> UIImage? in
                return UIImage(data: data)
            }
            .catch { error in
                return Just(nil)
            }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.imageCache[url] = image
            })
            .subscribe(on: DispatchQueue.global())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
