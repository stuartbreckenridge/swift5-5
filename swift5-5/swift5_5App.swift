//
//  swift5_5App.swift
//  swift5-5
//
//  Created by Stuart Breckenridge on 29/05/2021.
//

import SwiftUI

@main
struct swift5_5App: App {
    
    @StateObject private var appModel = AppModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appModel)
        }
    }
}
