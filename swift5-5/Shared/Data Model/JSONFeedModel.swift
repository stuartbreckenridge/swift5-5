//
//  JSONFeedModel.swift
//  swift5-5
//
//  Created by Stuart Breckenridge on 29/05/2021.
//

import Foundation

// MARK: - JSONFeed
public struct JSONFeed: Codable {
    public let version: String?
    public let title: String?
    public let homePageurl: String?
    public let feedurl: String?
    public let icon: String?
    public let favicon: String?
    public let items: [Item]?

    enum CodingKeys: String, CodingKey {
        case version = "version"
        case title = "title"
        case homePageurl = "home_page_url"
        case feedurl = "feed_url"
        case icon = "icon"
        case favicon = "favicon"
        case items = "items"
    }

    public init(version: String?, title: String?, homePageurl: String?, feedurl: String?, icon: String?, favicon: String?, items: [Item]?) {
        self.version = version
        self.title = title
        self.homePageurl = homePageurl
        self.feedurl = feedurl
        self.icon = icon
        self.favicon = favicon
        self.items = items
    }
}

// MARK: - Item
public struct Item: Codable {
    public let title: String?
    public let id: String?
    public let url: String?
    public let summary: String?
    public let contenthtml: String?
    public let contentText: String?
    public let author: Author?
    public let authors: [Author?]?
    public let datePublished: String?
    public let externalurl: String?
    public let image: String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case id = "id"
        case url = "url"
        case summary = "summary"
        case contenthtml = "content_html"
        case contentText = "content_text"
        case author = "author"
        case authors = "authors"
        case datePublished = "date_published"
        case externalurl = "external_url"
        case image = "image"
    }

    public init(title: String?, id: String?, url: String?, summary: String?, contenthtml: String?, contentText: String?, author: Author?, authors: [Author?]?, datePublished: String?, externalurl: String?, image: String?) {
        self.title = title
        self.id = id
        self.url = url
        self.summary = summary
        self.contenthtml = contenthtml
        self.contentText = contentText
        self.author = author
        self.authors = authors
        self.datePublished = datePublished
        self.externalurl = externalurl
        self.image = image
    }
}

// MARK: - Author
public struct Author: Codable {
    public let name: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
    }

    public init(name: String?) {
        self.name = name
    }
}
