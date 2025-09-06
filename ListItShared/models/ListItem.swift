//
//  ListItem.swift
//  ListIt
//
//  Created by Yuunan kin on 2025/09/06.
//

import Foundation
import SwiftData

@Model
public final class ListItem {
    public var id: UUID = UUID()

    public var name: String = ""
    public var isChecked: Bool = false
    public var createdAt: Date = Date()
    public var updatedAt: Date = Date()

    // Relationship to category
    public var category: ListCategory?

    init(name: String, category: ListCategory? = nil, isChecked: Bool = false) {
        id = UUID()
        self.name = name
        self.category = category
        self.isChecked = isChecked
        createdAt = Date()
        updatedAt = Date()
    }
}
