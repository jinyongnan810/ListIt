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

    @State private var pendingDelete: ListCategory?
    @State private var showDeleteAlert = false

    @State private var reversed: Bool = false
    private var sortedCategories: [ListCategory] {
        reversed ? categories.reversed() : categories
    }

    var body: some View {
        NavigationSplitView {
            List(selection: $currentCategory) {
                ForEach(sortedCategories) { category in
                    NavigationLink(category.name, value: category)
                }.onDelete { indexSet in
                    let category = sortedCategories[indexSet.first!]
                    pendingDelete = category
                    showDeleteAlert = true
                }
            }
            .navigationBarTitle("Categories")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    TextFieldLink(prompt: Text("New Category")) {
                        Label("Add", systemImage: "plus")
                    } onSubmit: { text in
                        dataStore.addCategory(name: text)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        reversed.toggle()
                    }) {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
        } detail: {
            if let currentCategory {
                ListItemView(currentCategory)
            } else {
                Text("No category selected")
            }
        }.alert("Delete Category?", isPresented: $showDeleteAlert, presenting: pendingDelete) { category in
            Button("Delete", role: .destructive) {
                dataStore.deleteCategory(category)
            }
            Button("Cancel", role: .cancel) {}
        } message: { category in
            Text("Are you sure you want to delete \"\(category.name)\"?")
        }
    }
}
