//
//  Home.swift
//  practicingtca
//
//  Created by TI Digital on 06/11/22.
//

import Foundation

import Combine
import ComposableArchitecture


struct Home: ReducerProtocol {
    @Dependency(\.newsClient) var news
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            return .task {
                await .loadMovie( TaskResult { try await self.news.fetch() })
            }
        case let .loadMovie(.success(movie)):
            
            state.movieList = movie
            return .none
        case let .loadMovie(.failure(error)):
            state.errorMessage = error.localizedDescription
            return .none
        case .movieTapped:
            return .none
        case .loadMoreMovie:
            return .none
        }
    }
    
    struct State: Equatable {
        var movieList: [Articles] = []
        var errorMessage: String?
    }
    
    enum Action: Equatable {
        case onAppear
        case loadMovie(TaskResult<[Articles]>)
        case movieTapped
        case loadMoreMovie
    }
}
