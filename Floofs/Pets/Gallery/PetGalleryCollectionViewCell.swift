//
// PetGalleryCollectionViewCell.swift
// Floofs
//

import UIKit
import Kingfisher

final class PetGalleryCollectionViewCell: UICollectionViewCell, ImagesLoadingView {

    // MARK: - Properties

    lazy var imageView: UIImageView = {
        let view = UIImageView.autoLayoutView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .placeholderGray
        view.tintColor = .black
        return view
    }()

    // MARK: - Constructor

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        clipsToBounds = true

        contentView.addSubviews(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
    }
}
