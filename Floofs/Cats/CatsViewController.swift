//
// CatsViewController.swift
// Floofs
//

import UIKit
import CatsAPI

final class CatsViewController: UITableViewController {

    private let dataSource: CatsDataSource

    init(dataSource: CatsDataSource) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self

        dataSource.fetchCats { [weak self] success in
            if success {
                self?.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Temporarily:
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cat = dataSource.cats[indexPath.row]
        var cellContext = cell.defaultContentConfiguration()
        cellContext.text = cat.breed
        cell.contentConfiguration = cellContext
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.cats.count
    }
}

