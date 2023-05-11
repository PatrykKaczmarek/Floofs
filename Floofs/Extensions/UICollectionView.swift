//
// UICollectionView.swift
// Floofs
//

import UIKit

extension UICollectionView {

    func register<Cell: UICollectionViewCell>(dequeueableCell: Cell.Type) {
        register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }

    func dequeue<Cell: UICollectionViewCell>(dequeueableCell: Cell.Type, forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell of type \(Cell.self) with reuseIdentifier \(Cell.reuseIdentifier)")
        }
        return cell
    }
}
