//
//  ListItApp.swift
//  ListIt Watch App
//
//  Created by Yuunan kin on 2025/09/05.
//

import ListItShared
import SwiftData
import SwiftUI

@main
struct ListIt_Watch_AppApp: App {
    @State private var dataStore = MyDataStore.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(dataStore.modelContainer)
                .environment(dataStore)
        }
    }
}
