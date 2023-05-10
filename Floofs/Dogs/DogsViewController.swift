//
//  ViewController.swift
//  Floofs
//

import UIKit
import DogsAPI

final class DogsViewController: UITableViewController {
    private let dogsAPIClient = DogsAPIClient(urlSession: .shared)

    private var dogs: [Dog] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self

        dogsAPIClient.fetchAllBreeds { [weak self] result in
            switch result {
            case .success(let dogs):
                self?.dogs = dogs
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Temporarily:
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dog = dogs[indexPath.row]
        var cellContext = cell.defaultContentConfiguration()
        cellContext.text = dog.breed
        cellContext.secondaryText = dog.subbreed
        cell.contentConfiguration = cellContext
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dogs.count
    }
}
