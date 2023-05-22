//
// ImagesLoadingView.swift
// Floofs
//

import Kingfisher
import UIKit

protocol ImagesLoadingView {
    /// An image view where the downloaded image should be displayed.
    var imageView: UIImageView { get }

    /// Downloads an image from given url and
    /// - Parameters:
    ///   - string: An url pointing to the external resource.
    ///   - placeholder: A placeholder that should be visible while loading an image.
    func setImage(url string: String?, placeholder: UIImage)
}

extension ImagesLoadingView where Self: AnyObject {
    func setImage(
        url string: String?,
        placeholder: UIImage = #imageLiteral(resourceName: "placeholder_paw")
    ) {
        guard let urlString = string else {
            imageView.image = placeholder
            return
        }
        let url = URL(string: urlString)
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ]
        )
    }
}
