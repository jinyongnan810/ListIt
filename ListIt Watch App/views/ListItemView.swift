//
//  ListItemView.swift
//  ListIt
//
//  Created by Yuunan kin on 2025/09/06.
//

import ListItShared
import SwiftData
import SwiftUI

struct ListItemView: View {
    let category: ListCategory
    @Environment(MyDataStore.self) var dataStore

    @Query var items: [ListItem]

    init(_ category: ListCategory) {
        self.category = category
        let categoryId = category.id
        let filter = #Predicate<ListItem> { item in
            item.category?.id == categoryId
        }
        let sort = [SortDescriptor(\ListItem.createdAt, order: .reverse)]
        _items = Query(filter: filter, sort: sort)
    }

    var body: some View {
        List {
            ForEach(items) { item in
                Text(item.name)
            }.onDelete { indexSet in
                let item = items[indexSet.first!]
                dataStore.deleteItem(item)
            }
        }.navigationTitle(category.name)
            .toolbar {
                TextFieldLink(prompt: Text("New Item")) {
                    Label("Add", systemImage: "plus")
                } onSubmit: { text in
                    dataStore.addItem(name: text, to: category)
                }
            }
    }
}
