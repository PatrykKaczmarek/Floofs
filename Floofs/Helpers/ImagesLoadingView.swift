//
// ImagesLoadingView.swift
// Floofs
//

import Kingfisher
import UIKit

protocol ImagesLoadingView {

    var imageView: UIImageView { get }

    var activityIndicatorView: UIActivityIndicatorView { get }

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
        activityIndicatorView.startAnimating()
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
            ],
            completionHandler: { [weak self] _ in
                self?.activityIndicatorView.stopAnimating()
            }
        )
    }
}
