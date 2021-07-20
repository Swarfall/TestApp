//
//  ListViewController.swift
//  LaroApp
//
//  Created by Viacheslav Savitskyi on 16.07.2021.
//

import UIKit

final class ListViewController: BaseViewController {
    
    private enum Constants {
        static let estimatedRowHeight: CGFloat = 130
        static let activityIndicatorHeight: CGFloat = 44
    }
    
    // MARK: - Outlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private property
    private lazy var reloadRefreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshingReload(sender:)), for: .valueChanged)
        refresh.tintColor = .blue
        refresh.attributedTitle = NSAttributedString(string: "Reload...")
        return refresh
    }()

    // MARK: - Public property
    var presenter: ListViewOutput?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configureTableView()
        presenter?.viewDidLoad()
    }
}

// MARK: - Private
private extension ListViewController {
    func registerCell() {
        tableView.register(UINib(nibName: String(describing: GiphyCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: GiphyCell.self))
    }
    
    func configureTableView() {
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.refreshControl = reloadRefreshControl
    }
    
    @objc func refreshingReload(sender: UIRefreshControl) {
        presenter?.refresh()
        sender.endRefreshing()
    }
}

// MARK: - ListViewInput
extension ListViewController: ListViewInput {
    func reloadData() {
        tableView.reloadData()
    }
    
    func show(message: String) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.itemsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GiphyCell.self), for: indexPath) as? GiphyCell else { return UITableViewCell() }
        cell.update(with: presenter?.itemAt(index: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if presenter?.isStartLoadingFrom(index: indexPath) == true {
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.startAnimating()
            activityIndicator.frame = CGRect(x: 0,
                                             y: 0,
                                             width: tableView.bounds.width,
                                             height: Constants.activityIndicatorHeight)
            
            tableView.tableFooterView = activityIndicator
            tableView.tableFooterView?.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelect(index: indexPath)
    }
}
