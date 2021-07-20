//
//  ListProtocols.swift
//  LaroApp
//
//  Created by Viacheslav Savitskyi on 16.07.2021.
//

import UIKit

protocol ListViewOutput: AnyObject {
    func viewDidLoad()
    func itemsCount() -> Int
    func itemAt(index: IndexPath) -> GiphyData
    func refresh()
    func isStartLoadingFrom(index: IndexPath) -> Bool
    func didSelect(index: IndexPath)
}

protocol ListViewInput: AnyObject {
    func showLoader()
    func hideLoader()
    func reloadData()
    func show(message: String)
}
