//
// UICollectionView.swift
// Floofs
//

import UIKit

extension UICollectionView {
    /// Registers `Cell` type to be reusable by the receiver.
    /// - Parameter dequeueableCell: A cell type to register.
    func register<Cell: UICollectionViewCell>(dequeueableCell: Cell.Type) {
        register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }

    /// Dequeues a reusable cell object located by its identifier.
    /// - Warning: Register a cell by invoking a `UICollectionView.register(dequeueableCell:)` function
    ///            before dequeuing it.
    /// - Parameters:
    ///   - dequeueableCell: The cell type to dequeue.
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A properly dequeued  type of `UICollectionViewCell`.
    func dequeue<Cell: UICollectionViewCell>(
        dequeueableCell: Cell.Type,
        forIndexPath indexPath: IndexPath
    ) -> Cell {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: Cell.reuseIdentifier,
            for: indexPath
        ) as? Cell else {
            fatalError("Could not dequeue cell of type \(Cell.self) with reuseIdentifier \(Cell.reuseIdentifier)")
        }
        return cell
    }
}
