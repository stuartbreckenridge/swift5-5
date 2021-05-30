//
//  RootView.swift
//  swift5-5
//
//  Created by Stuart Breckenridge on 29/05/2021.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject private var appModel: AppModel
    @State private var selection: Int = 1
    
    var body: some View {
        TabView(selection: $selection,
                content:  {
                    ArticleListAsyncAwaitView().tabItem {
                        Image(systemName: "scribble.variable")
                        Text("Async/Await")
                    }
                    .tag(1)
                })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
