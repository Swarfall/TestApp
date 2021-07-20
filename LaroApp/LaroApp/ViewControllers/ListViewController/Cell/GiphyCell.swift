//
//  GiphyCell.swift
//  LaroApp
//
//  Created by Viacheslav Savitskyi on 16.07.2021.
//

import UIKit

final class GiphyCell: UITableViewCell {
    
    private enum Constant {
        static let cornerRadius: CGFloat = 8
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
    }
    
    // MARK: - Public method
    func update(with post: GiphyData?) {
        guard let post = post else { return }

        avatarImageView.loadImageUsingCache(withUrl: post.user?.avatarURL ?? AppConstants.baseAvatarURL)

        titleLabel.text = post.title
        authorLabel.text = "Author: \(post.username)"
        idLabel.text = "id: \(post.id)"
        dateLabel.text = "Import: \(transform(date: post.importDatetime))"
    }
}

// MARK: -  Private
private extension GiphyCell {
    func setupView() {
        backView.layer.cornerRadius = Constant.cornerRadius
        backView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = Constant.cornerRadius
    }
    
    func transform(date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let dateForm = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: dateForm)
        } else {
        return "No info"
        }
    }
}
