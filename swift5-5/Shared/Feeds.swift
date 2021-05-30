//
//  Feeds.swift
//  swift5-5
//
//  Created by Stuart Breckenridge on 29/05/2021.
//

import Foundation

public enum FeedChoice: CaseIterable, Identifiable {
    
    case daringFireball
    case inessential
    case macstories
    
    public var id: String {
        name
    }
    
    var url: URL {
        switch self {
        case .daringFireball:
            return Feeds.daringFireball
        case .inessential:
            return Feeds.inessential
        case .macstories:
            return Feeds.macstories
        }
    }
    
    var name: String {
        switch self {
        case .daringFireball:
            return "Daring Fireball"
        case .inessential:
            return "Inessential"
        case .macstories:
            return "MacStories"
        }
    }
    
}

private struct Feeds {
    static let daringFireball = URL(string: "https://daringfireball.net/feeds/json")!
    static let inessential = URL(string: "https://inessential.com/feed.json")!
    static let macstories = URL(string: "https://www.macstories.net/feed/json/")!
}


enum FeedError: Error {
    case noData
}
