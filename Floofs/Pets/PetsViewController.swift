//
// PetsViewController.swift
// Floofs
//

import UIKit

final class PetsViewController: UITableViewController {

    // MARK: - Properties

    private let dataSource: any PetsDataSource

    // MARK: - Constructor

    init(dataSource: any PetsDataSource) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK - API

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self

        dataSource.fetchPets { [weak self] success in
            if success {
                self?.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Temporarily:
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let pet = dataSource.pets[indexPath.row]
        var cellContext = cell.defaultContentConfiguration()
        cellContext.text = pet.displayName
        cellContext.secondaryText = "Images count: \(pet.imageURLs.count)"
        cell.contentConfiguration = cellContext
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.pets.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dataSource.fetchImages(petIndex: indexPath.row) { [weak self] success in
            if success {
                self?.tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
}
