//
// AppLaunchFailureViewController.swift
// Floofs
//

import UIKit

final class AppLaunchFailureViewController: UIViewController {

    private let error: AppConfigError?

    private var failureReason: String {
        error.flatMap {
            [$0.localizedDescription, $0.recoverySuggestion].joined(separator: "\n")
        } ?? "Something went wrong"
    }

    init(error: AppConfigError?) {
        self.error = error
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 1)

        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = """
        Opps 🙊 This is embarrassing...

        \(failureReason)
        """
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
            label.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 16),
            label.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16)
        ])
    }
}
