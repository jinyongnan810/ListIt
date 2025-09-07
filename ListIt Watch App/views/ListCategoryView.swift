//
//  ListCategoryView.swift
//  ListIt
//
//  Created by Yuunan kin on 2025/09/06.
//

import ListItShared
import SwiftData
import SwiftUI

struct ListCategoryView: View {
    @Environment(MyDataStore.self) var dataStore
    @Query(filter: nil, sort: [SortDescriptor(\ListCategory.createdAt)]) var categories: [ListCategory]
    @State private var currentCategory: ListCategory?

    var body: some View {
        NavigationSplitView {
            List(selection: $currentCategory) {
                ForEach(categories) { category in
                    NavigationLink(category.name, value: category)
                }.onDelete { indexSet in
                    let category = categories[indexSet.first!]
                    dataStore.deleteCategory(category)
                }
            }
            .navigationBarTitle("Categories")
            .toolbar {
                TextFieldLink(prompt: Text("New Category")) {
                    Label("Add", systemImage: "plus")
                } onSubmit: { text in
                    dataStore.addCategory(name: text)
                }
            }
        } detail: {
            if let currentCategory {
                ListItemView(currentCategory)
            } else {
                Text("No category selected")
            }
        }
    }
}
