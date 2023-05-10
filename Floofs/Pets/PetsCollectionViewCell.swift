//
// PetsCollectionViewCell.swift
// Floofs
//
        

import UIKit
import Kingfisher

final class PetsCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    private lazy var activityView = UIActivityIndicatorView(style: .large).layoutable()

    private lazy var titleLabel: UILabel = {
        let label = UILabel.autoLayoutView()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private lazy var imageView: UIImageView = {
        let view = UIImageView.autoLayoutView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    private lazy var blurEffectView: UIView = {
        if UIAccessibility.isReduceTransparencyEnabled {
            let view = UIView.autoLayoutView()
            view.backgroundColor = .black
            return view
        }
        return UIVisualEffectView(effect: UIBlurEffect(style: .dark)).layoutable()
    }()

    // MARK: - Constructor

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor

        addSubviews(imageView, blurEffectView, titleLabel, activityView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurEffectView.topAnchor.constraint(greaterThanOrEqualTo: imageView.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: blurEffectView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: blurEffectView.bottomAnchor, constant: -8),

            activityView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: centerYAnchor)
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
        titleLabel.text = nil
    }

    // MARK: - API

    func setImage(url string: String?) {
        let placeholder = UIImage(named: "paw")
        guard let urlString = string else {
            imageView.image = placeholder
            return
        }
        activityView.startAnimating()
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
            ])
        { [weak self] result in
            self?.activityView.stopAnimating()
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
