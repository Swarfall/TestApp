//
//  DetailPresenter.swift
//  LaroApp
//
//  Created by Viacheslav Savitskyi on 17.07.2021.
//

import UIKit

final class DetailPresenter: NSObject {
    weak var view: DetailInput?
    private let router: DetailRouter
    private let url: URL?
    
    init(router: DetailRouter, url: URL?) {
        self.router = router
        self.url = url
        super.init()
        self.getImage()
    }
}

// MARK: - ListViewOutput

extension DetailPresenter: DetailOutput {
    func save(image: UIImage?) {
        guard let image = image else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        view?.showLoader()
    }
}

// MARK: Private
private extension DetailPresenter {
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            view?.show(message: error.localizedDescription)
        } else {
            view?.show(message: "Saved")
        }
        
        view?.hideLoader()
    }
    
    func getImage() {
        guard let url = url else {
            view?.show(message: GiphyError.defaultError.localizedDescription)
            return
        }
        
        view?.showLoader()
        ImageLoader.loadImage(with: url) { image in
            DispatchQueue.main.async {
                self.view?.hideLoader()
                
                guard let image = image else {
                    self.view?.show(message: GiphyError.defaultError.localizedDescription)
                    return
                }
                
                self.view?.show(image: image)
            }
        }
    }
}
