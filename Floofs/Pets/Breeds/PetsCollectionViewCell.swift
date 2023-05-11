//
// PetsCollectionViewCell.swift
// Floofs
//
        

import UIKit

final class PetsCollectionViewCell: UICollectionViewCell, ImagesLoadingView {

    // MARK: - Properties

    static let estimatedTitleHeight: CGFloat = 40
    private let cornerRadius: CGFloat = 8

    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    lazy var activityIndicatorView = UIActivityIndicatorView(style: .large).layoutable()

    private lazy var titleLabel: UILabel = {
        let label = UILabel.autoLayoutView()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

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

        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true

        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)

        contentView.addSubviews(imageView, titleLabel, activityIndicatorView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            activityIndicatorView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
        titleLabel.text = nil
        activityIndicatorView.stopAnimating()
    }
}
