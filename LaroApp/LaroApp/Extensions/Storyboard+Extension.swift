//
//  Storyboard+Extension.swift
//  LaroApp
//
//  Created by Viacheslav Savitskyi on 16.07.2021.
//

import UIKit

protocol Storyboardable {
    static var storyboardName: String { get }
}

extension Storyboardable where Self: UIViewController {
    static var storyboardName: String {
        return String(describing: self)
    }

    static func storyboardViewController<T: UIViewController>() -> T {
        let storyboard = UIStoryboard(name: T.storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? T else {
            fatalError("Could not instantiate initial storyboard with name: \(T.storyboardName)")
        }

        return viewController
    }
}

extension UIViewController: Storyboardable { }


