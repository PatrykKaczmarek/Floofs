//
// PetsViewController.swift
// Floofs
//


import UIKit

final class PetsViewController: UIViewController {

    // MARK: - Properties

    private let dataSource: any PetsDataSource

    private lazy var customView = PetsView()

    // MARK: - Constructor

    init(dataSource: any PetsDataSource) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customView.collectionView.dataSource = self
        customView.collectionView.delegate = self
        customView.collectionView.register(dequeueableCell: PetsCollectionViewCell.self)

        customView.activityView.startAnimating()
        dataSource.fetchPets { [weak self] success in
            self?.customView.activityView.stopAnimating()
            if success {
                self?.customView.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension PetsViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeue(
            dequeueableCell: PetsCollectionViewCell.self,
            forIndexPath: indexPath
        )
        let pet = dataSource.pets[indexPath.row]
        cell.title = pet.displayName
        DispatchQueue.main.async {
            cell.setImage(url: pet.coverImageURL)
        }
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        dataSource.pets.count
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PetsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let halfScreenWidth = collectionView.bounds.width * 0.5
        return CGSize(width: halfScreenWidth, height: halfScreenWidth)
    }
}
