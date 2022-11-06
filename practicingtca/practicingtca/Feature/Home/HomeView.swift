//
//  HomeView.swift
//  practicingtca
//
//  Created by TI Digital on 06/11/22.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let store: StoreOf<Home>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewStore.movieList) { data in
                        Text(data.title)
                            .multilineTextAlignment(.leading)
                            .padding()
                    }
                }
            }
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
