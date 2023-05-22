//
// PetGalleryViewController.swift
// Floofs
//

import  UIKit

final class PetGalleryViewController: UIViewController {

    // MARK: - Properties

    private(set) var pet: Pet

    private let imagesProvider: any PetImageDataProviding

    private lazy var customView = PetGalleryView()

    // MARK: - Constructor

    init(pet: Pet, imagesProvider: any PetImageDataProviding) {
        self.pet = pet
        self.imagesProvider = imagesProvider
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

        title = pet.displayName

        customView.collectionView.dataSource = self
        customView.collectionView.delegate = self
        customView.collectionView.register(dequeueableCell: PetGalleryCollectionViewCell.self)
        fetchImages()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - UICollectionViewDataSource

extension PetGalleryViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeue(
            dequeueableCell: PetGalleryCollectionViewCell.self,
            forIndexPath: indexPath
        )
        if let imageURL = pet.imageURLs[safe: indexPath.item] {
            DispatchQueue.main.async {
                cell.setImage(url: imageURL)
            }
        }
        fetchImages(currentIndexPath: indexPath)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        pet.imageURLs.count
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PetGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let halfScreenWidth = collectionView.bounds.width * 0.5
        return CGSize(width: halfScreenWidth, height: halfScreenWidth)
    }
}

// MARK: - Private

private extension PetGalleryViewController {
    func fetchImages(currentIndexPath indexPath: IndexPath? = nil) {
        let isLastCell = indexPath.flatMap { $0.item == pet.imageURLs.count - 1 } ?? true
        guard isLastCell, !imagesProvider.imagesFetchCompleted(for: pet) else {
            return
        }

        if pet.imageURLs.count == 0 {
            customView.activityView.startAnimating()
        }

        imagesProvider.fetchImages(pet: pet) { [weak self] pet in
            self?.pet = pet
            self?.customView.activityView.stopAnimating()
            self?.customView.collectionView.reloadData()
        }
    }
}
