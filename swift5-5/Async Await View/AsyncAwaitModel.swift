//
//  AsyncAwaitModel.swift
//  swift5-5
//
//  Created by Stuart Breckenridge on 29/05/2021.
//

import Foundation
import Combine

class AsyncAwaitModel: ObservableObject {
    
    // Published
    @Published public var showError: Bool = false
    
    // Public Variables
    public private(set) var feedItems: [Item] = []
    public private(set) var feedTitle: String = ""
    public private(set) var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    public private(set) var error: Error? {
        didSet {
            DispatchQueue.main.async {
                if self.error != nil {
                    self.showError = true
                } else {
                    self.showError = false
                }
            }
        }
    }
    
    // Private Variables
    private var bag = Set<AnyCancellable>()
    
    public func refreshFeed(_ feedURL: URL) async {
        if isLoading { return }
        do {
            print("Started Downloading Data")
            self.isLoading = true
            let data = try await downloadFeedData(feedURL)
            self.feedItems = data.items ?? []
            self.feedTitle = data.title ?? ""
            self.isLoading = false
            print("Finished Downloading Data")
        } catch {
            self.error = error
            self.isLoading = false
            print("Finished Downloading Data with error:", error.localizedDescription)
        }
    }
    
    private func downloadFeedData(_ feedURL: URL) async throws -> JSONFeed {
        print(#function)
        let urlRequest = URLRequest(url: feedURL)
        return try await withUnsafeThrowingContinuation { continuation in
            URLSession.shared.dataTaskPublisher(for: urlRequest)
                .tryMap { data, response -> Data in
                    return data
                }
                .decode(type: JSONFeed.self, decoder: JSONDecoder())
                .receive(on: OperationQueue.main, options: .none)
                .sink { result in
                    switch result {
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    case .finished:
                        return
                    }
                } receiveValue: { feed in
                    continuation.resume(returning: feed)
                }
                .store(in: &bag)
        }
    }
    
}
