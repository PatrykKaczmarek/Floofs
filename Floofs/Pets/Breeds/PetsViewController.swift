//
// PetsViewController.swift
// Floofs
//


import UIKit

protocol PetsViewControllerNavigationDelegate: AnyObject {
    func pets(viewController: PetsViewController, didSelect pet: Pet)
}

final class PetsViewController: UIViewController {

    // MARK: - Properties

    let dataSource: any PetsDataSource

    weak var navigationDelegate: PetsViewControllerNavigationDelegate?

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
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
        let pet = dataSource.pets[indexPath.item]
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
        let collectionViewWidth = collectionView.bounds.width
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize(
                width: collectionViewWidth * 0.5,
                height: collectionViewWidth * 0.5
            )
        }
        let reducedCollectionViewWidth = (collectionViewWidth - flowLayout.minimumInteritemSpacing - flowLayout.sectionInset.left - flowLayout.sectionInset.right) * 0.5
        let reducedCollectionViewHeight = (collectionViewWidth - flowLayout.minimumLineSpacing - flowLayout.sectionInset.top - flowLayout.sectionInset.bottom) * 0.5
        return CGSize(
            width: reducedCollectionViewWidth,
            height: reducedCollectionViewHeight + PetsCollectionViewCell.estimatedTitleHeight
        )
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationDelegate?.pets(viewController: self, didSelect: dataSource.pets[indexPath.item])
    }
}
