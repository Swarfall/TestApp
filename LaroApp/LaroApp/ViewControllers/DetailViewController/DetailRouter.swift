//
//  DetailRouter.swift
//  LaroApp
//
//  Created by Viacheslav Savitskyi on 17.07.2021.
//

import UIKit

final class DetailRouter {
    private var url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    func build() -> DetailViewController {
        let viewController = ListViewController.storyboardViewController() as DetailViewController
        let presenter = DetailPresenter(router: self, url: url)
        viewController.presenter = presenter
        presenter.view = viewController
       
        return viewController
    }
}
