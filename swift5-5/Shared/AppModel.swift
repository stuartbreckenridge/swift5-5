//
//  AppModel.swift
//  swift5-5
//
//  Created by Stuart Breckenridge on 30/05/2021.
//

import Foundation
import Combine

public final class AppModel: NSObject, ObservableObject {
    
    @Published var feedChoice: FeedChoice = .daringFireball
    
}

