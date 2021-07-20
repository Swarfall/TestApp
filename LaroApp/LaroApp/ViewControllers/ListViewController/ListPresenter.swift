//
//  ListPresenter.swift
//  LaroApp
//
//  Created by Viacheslav Savitskyi on 16.07.2021.
//

import UIKit

final class ListPresenter {
    private struct Constants {
        static let limit = 20
        static let startToPagination = 15
    }
    
    // MARK: - Public property
    weak var view: ListViewInput?
    
    //MARK: - Private properties
    private let router: ListRouter
    private let postRequests: PostRequests
    private var currentLimit = 25
    private var posts: [GiphyData] = []
    
    init(router: ListRouter, networkClient: PostRequests) {
        self.router = router
        self.postRequests = networkClient
    }
}

// MARK: - ListViewOutput
extension ListPresenter: ListViewOutput {
    func itemsCount() -> Int {
        return posts.count
    }
    
    func itemAt(index: IndexPath) -> GiphyData {
        return posts[index.row]
    }
    
    func viewDidLoad() {
        view?.showLoader()
        getPosts()
    }
    
    func refresh() {
        currentLimit = Constants.limit
        getPosts()
    }
    
    func isStartLoadingFrom(index: IndexPath) -> Bool {
        let shouldStart = currentLimit - Constants.startToPagination < index.row
        if shouldStart {
            currentLimit += Constants.limit
            getPosts(pagination: true)
        }
        
        return shouldStart
    }
    
    func didSelect(index: IndexPath) {
        guard let url = URL(string: posts[index.row].user?.avatarURL ?? AppConstants.baseAvatarURL) else {
            view?.show(message: GiphyError.defaultError.localizedDescription)
            return
        }
        router.showImageWith(url: url)
    }
}

// MARK: Private
private extension ListPresenter {
    func getPosts(pagination: Bool = false) {
        postRequests.getPosts(limit: currentLimit) { [weak self] posts in
            if pagination {
                self?.posts.append(contentsOf: posts)
            } else {
                self?.posts = posts
            }
            DispatchQueue.main.async {
                self?.view?.hideLoader()
                self?.view?.reloadData()
            }
        } failure: { [weak self] error in
            DispatchQueue.main.async {
                self?.view?.hideLoader()
                if let error = error {
                    self?.view?.show(message: error.localizedDescription)
                }
            }
        }
    }
}
