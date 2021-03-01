//
//  EmptyList.swift
//  CalendarCard
//
//  Created by iOS on 2021/2/23.
//

import SwiftUI

public struct EmptyList<Items: RandomAccessCollection, ListRowView: View, EmptyListView: View>: View where Items.Element: Identifiable {
    
    private var items: Items
    private var listRowView: (Items.Element) -> ListRowView
    private let emptyListView: () -> EmptyListView
    private let onDelete: (IndexSet) -> Void

    public init(_ items: Items,
                @ViewBuilder listRowView: @escaping (Items.Element) -> ListRowView,
                @ViewBuilder emptyListView: @escaping () -> EmptyListView,
                onDelete : @escaping (IndexSet) -> Void) {
        self.items = items
        self.listRowView = listRowView
        self.emptyListView = emptyListView
        self.onDelete = onDelete

    }
    
    public var body: some View {
        Group {
            if !items.isEmpty {
                List {
                    ForEach(items) { item in
                        self.listRowView(item)
                    }
                    .onDelete { index in
                        self.onDelete(index)
                    }
                }
            } else {
                emptyListView()
            }
        }
    }
}
