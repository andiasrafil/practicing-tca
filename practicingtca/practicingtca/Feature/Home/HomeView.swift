//
//  HomeView.swift
//  practicingtca
//
//  Created by TI Digital on 06/11/22.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    @State var isLoading = false
    let store: StoreOf<Home>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(viewStore.movieList) { data in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(data.title)
                                    .font(.headline)
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal)
                                Text(data.articleDescription ?? "")
                                    .multilineTextAlignment(.leading)
                                    .font(.caption)
                                    .padding(.horizontal)
                            }
                            .padding(.bottom)
                            
                        }
                    }
                    if self.isLoading {
                        VStack {
                            ProgressView()
                            Button("cancel") {
                                viewStore.send(.cancelTapped, animation: .default)
                            }
                        }
                    }
                }
                .refreshable {
                    Task {
                        self.isLoading = true
                        defer { self.isLoading = false }
                        await viewStore.send(.refresh).finish()
                    }
                }
            }
            .background(Color.white)
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: Store(initialState: Home.State(), reducer: Home()))
    }
}
