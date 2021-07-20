//
//  ListRouter.swift
//  LaroApp
//
//  Created by Viacheslav Savitskyi on 16.07.2021.
//

import UIKit

protocol ListRouterDelegate: AnyObject {
    func showImageWith(url: URL)
}

final class ListRouter {
    private weak var delegate: ListRouterDelegate?
    
    init(delegate: ListRouterDelegate) {
        self.delegate = delegate
    }
    
    func build() -> ListViewController {
        let viewController = ListViewController.storyboardViewController() as ListViewController
        let presenter = ListPresenter(router: self, networkClient: PostRequests())
        viewController.presenter = presenter
        presenter.view = viewController
       
        return viewController
    }
    
    func showImageWith(url: URL) {
        delegate?.showImageWith(url: url)
    }
}
