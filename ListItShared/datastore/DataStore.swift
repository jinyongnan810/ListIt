//
//  DataStore.swift
//  ListIt
//
//  Created by Yuunan kin on 2025/09/06.
//
import Observation
import SwiftData
import SwiftUI

// MARK: ModelContainer

extension ModelContainer {
    static func createContainer() throws -> ModelContainer {
        let schema = Schema([
            ListCategory.self,
            ListItem.self,
        ])

        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false,
            allowsSave: true,
            groupContainer: .identifier("group.com.kinn.ListIt"),
            cloudKitDatabase: .automatic // Enable CloudKit sync
        )

        return try ModelContainer(
            for: schema,
            configurations: [modelConfiguration]
        )
    }
}

@MainActor
@Observable
public class MyDataStore {
    public static let shared = MyDataStore()

    public let modelContainer: ModelContainer
    public let modelContext: ModelContext

    private init() {
        do {
            // Use the shared container with CloudKit enabled
            modelContainer = try ModelContainer.createContainer()
            modelContext = modelContainer.mainContext

            // Configure auto-save
            modelContext.autosaveEnabled = true

        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    // MARK: - Category Operations

    public func addCategory(name: String) {
        let category = ListCategory(name: name)
        modelContext.insert(category)
        save()
    }

    public func deleteCategory(_ category: ListCategory) {
        modelContext.delete(category)
        save()
    }

    // MARK: - Item Operations

    public func addItem(name: String, to category: ListCategory) -> ListItem {
        let item = ListItem(name: name, category: category)
        modelContext.insert(item)
        save()
        return item
    }

    public func toggleItem(_ item: ListItem) {
        item.isChecked.toggle()
        item.updatedAt = Date()
        save()
    }

    public func deleteItem(_ item: ListItem) {
        modelContext.delete(item)
        save()
    }

    // MARK: - Save

    private func save() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
