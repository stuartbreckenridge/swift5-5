//
//  ArticleListAsyncAwaitView.swift
//  swift5-5
//
//  Created by Stuart Breckenridge on 29/05/2021.
//

import SwiftUI
import Combine

struct ArticleListAsyncAwaitView: View {
    
    @EnvironmentObject private var appModel: AppModel
    @StateObject private var model = AsyncAwaitModel()
    
    var body: some View {
        NavigationView {
            List(model.feedItems, id: \.id, rowContent: { item in
                feedItemView(item)
            })
            .onAppear(perform: {
                detach {
                    await model.refreshFeed(appModel.feedChoice.url)
                }
            })
            .listStyle(PlainListStyle())
            .navigationBarItems(leading: leadingView(), trailing: trailingView())
            .navigationTitle(model.feedTitle)
            .alert(isPresented: $model.showError, content: {
                Alert(title: Text("Error"),
                      message: Text(model.error?.localizedDescription ?? "Unknown Error"),
                      dismissButton: Alert.Button.cancel({
                            model.showError = false
                      }))
            })
            .onChange(of: appModel.feedChoice, perform: { _ in
                detach {
                    await model.refreshFeed(appModel.feedChoice.url)
                }
            })
        }
    }
    
    private func leadingView() -> some View {
        model.isLoading ? AnyView(ProgressView()) : AnyView(EmptyView())
    }
    
    private func trailingView() -> some View {
        AnyView(
            HStack(spacing: 12) {
                Menu(content: {
                    ForEach(FeedChoice.allCases) { choice in
                        Button(action: {
                            appModel.feedChoice = choice
                        }, label: {
                            Text(choice.name)
                        })
                    }
                }, label: {
                    Image(systemName: "chevron.left.slash.chevron.right")
                })
                
                Button(action: {
                    detach {
                        await model.refreshFeed(appModel.feedChoice.url)
                    }
                }, label: {
                    Image(systemName: "arrow.clockwise")
                })
            }
        )
    }
    
    private func feedItemView(_ item: Item) -> some View {
        return VStack(alignment: .leading) {
            if let title = item.title {
                Text(title).font(.headline)
            } else if let content = item.contenthtml {
                Text(content).lineLimit(3)
            }
            Text(item.datePublished ?? "").font(.caption)
            if let author = item.author {
                Text(author.name ?? "").font(.caption)
            }
            else if let author = item.authors?[0] {
                Text(author.name ?? "").font(.caption)
            }
        }
    }
    
    
}

struct ArticleListAsyncAwait_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListAsyncAwaitView()
    }
}
