//
//  HomeEffect.swift
//  practicingtca
//
//  Created by TI Digital on 06/11/22.
//

import Foundation
import ComposableArchitecture

struct NewsClient {
    var fetch: () async throws -> [Articles]
}

private enum NewsClientKey: DependencyKey {
    static var liveValue: NewsClient {
        return NewsClient.liveValue
    }
}

extension NewsClient {
    static let liveValue = Self(fetch: {
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=dff5575e843847b9b86b333511070d78")!)
            let result = try JSONDecoder().decode(HomeModel.self, from: data)
            return result.articles
        } catch {
            throw APIError.decodingError
        }
    }
    )
}

extension DependencyValues {
    var newsClient: NewsClient {
        get { self[NewsClientKey.self] }
        set { self[NewsClientKey.self] = newValue }
    }
}
