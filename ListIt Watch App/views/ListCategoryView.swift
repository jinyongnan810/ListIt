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

    var body: some View {
        NavigationSplitView {
            List(selection: $currentCategory) {
                ForEach(categories) { category in
                    NavigationLink(category.name, value: category)
                }.onDelete { indexSet in
                    let category = categories[indexSet.first!]
                    pendingDelete = category
                    showDeleteAlert = true
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
