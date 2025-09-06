//
//  ListCategory.swift
//  ListIt
//
//  Created by Yuunan kin on 2025/09/06.
//

import Foundation
import SwiftData

@Model
public final class ListCategory {
    @Attribute(.unique)
    public var id: UUID

    public var name: String
    public var createdAt: Date
    public var updatedAt: Date

    // Cascade delete relationship
    @Relationship(deleteRule: .cascade, inverse: \ListItem.category)
    public var items: [ListItem]?

    public init(name: String) {
        id = UUID()
        self.name = name
        createdAt = Date()
        updatedAt = Date()
        items = []
    }
}
