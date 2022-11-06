//
//  practicingtcaApp.swift
//  practicingtca
//
//  Created by TI Digital on 06/11/22.
//

import SwiftUI
import ComposableArchitecture

@main
struct practicingtcaApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(store: Store(initialState: Home.State(), reducer: Home()))
        }
    }
}
