//
//  GiphyModel.swift
//  LaroApp
//
//  Created by Viacheslav Savitskyi on 16.07.2021.
//

import Foundation

// MARK: - Giphy
struct Giphy: Codable {
    let data: [GiphyData]
}

// MARK: - GiphyData
struct GiphyData: Codable {
    let id: String
    let title: String
    let username: String
    let importDatetime: String
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id, username, title, user
        case importDatetime = "import_datetime"
    }
}

// MARK: - User
struct User: Codable {
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
