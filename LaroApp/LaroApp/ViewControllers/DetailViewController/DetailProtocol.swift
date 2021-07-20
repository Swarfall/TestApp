//
//  DetailProtocol.swift
//  LaroApp
//
//  Created by Viacheslav Savitskyi on 17.07.2021.
//

import UIKit

protocol DetailOutput: AnyObject {
    func save(image: UIImage?)
}

protocol DetailInput: AnyObject {
    func showLoader()
    func hideLoader()
    func show(message: String)
    func show(image: UIImage)
}
