//
//  DetailViewController.swift
//  LaroApp
//
//  Created by Viacheslav Savitskyi on 17.07.2021.
//

import UIKit

final class DetailViewController: BaseViewController {
    
    // MARK: - Private outlet
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Public properties
    var presenter: DetailOutput?

    // MARK: - Override method
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
}

// MARK: - Private
private extension DetailViewController {
    func configureNavBar() {
        let save = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItem = save
    }
}

// MARK: - Action
private extension DetailViewController {
    @objc func saveTapped() {
        presenter?.save(image: imageView.image)
    }
}

// MARK: - DetailInput
extension DetailViewController: DetailInput {
    func show(image: UIImage) {
        imageView.image = image
    }
    
    func show(message: String) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
