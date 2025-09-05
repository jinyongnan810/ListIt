//
//  ContentView.swift
//  ListIt Watch App
//
//  Created by Yuunan kin on 2025/09/05.
//

import ListItShared
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(getSharedString())
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
