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
    @State private var showingAddDialog = false
    @State private var newCategoryName = ""

    var body: some View {
        NavigationSplitView {
            List(categories, selection: $currentCategory) { category in
                NavigationLink(category.name, value: category)
            }
            .navigationBarTitle("Categories")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showingAddDialog = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        } detail: {
            if let currentCategory {
                ListItemView(currentCategory)
            } else {
                Text("No category selected")
            }
        }

        .alert("Add Category", isPresented: $showingAddDialog) {
            TextField("Category Name", text: $newCategoryName)
            Button("Cancel", role: .cancel) {
                newCategoryName = ""
            }
            Button("Add") {
                dataStore.addCategory(name: newCategoryName)
                newCategoryName = ""
            }.disabled(newCategoryName == "")
        }
    }
}
