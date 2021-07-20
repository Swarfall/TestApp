//
//  Errors.swift
//  LaroApp
//
//  Created by Viacheslav Savitskyi on 16.07.2021.
//

import Foundation

enum GiphyError: Error {
    case tryAgain
    case defaultError
}

extension GiphyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .tryAgain:
            return NSLocalizedString("Try again", comment: "Try again")
        case .defaultError:
            return NSLocalizedString("Oooopps", comment: "Oooopps")
        }
    }
}
