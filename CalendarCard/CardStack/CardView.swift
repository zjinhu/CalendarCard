//
//  CardView.swift
//  Card
//
//  Created by iOS on 2021/1/26.
//

import SwiftUI

public let CardNotification = "CardNotification"

public struct CardStack<ID: Hashable, Data: RandomAccessCollection, Content: View>: View where Data.Index: Hashable {

    @State var index: Data.Index
    
    private let data: Data
    private let id: KeyPath<Data.Element, ID>
    private let content: (Data.Element) -> Content
    
    public init(index: Int,
                data: Data,
                id: KeyPath<Data.Element, ID>,
                @ViewBuilder content: @escaping (Data.Element) -> Content) {
        
        self.data = data
        self.id = id
        self.content = content
        self._index = State<Data.Index>(initialValue: index as! Data.Index)
    }
    
    public var body: some View {
        ZStack {
            ForEach(data.indices.reversed(), id: \.self) { index -> AnyView in
                let relativeIndex = self.data.distance(from: self.index, to: index)
                if relativeIndex >= 0 && relativeIndex < 5 {
                    return AnyView(self.card(index: index, relativeIndex: relativeIndex))
                } else {
                    return AnyView(EmptyView())
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name.init(CardNotification)), perform: { noti in
            if let num : Int = noti.object as? Int {
                index = num as! Data.Index
            }
        })
    }
    
    private func card(index: Data.Index, relativeIndex: Int) -> some View {
        CardView(onSwipe: {
            self.index = self.data.index(after: index)
        }, content: {
            self.content(self.data[index])
                .offset(x: 0,y: CGFloat(relativeIndex) * 10)
                .scaleEffect(1 - 0.1 * CGFloat(relativeIndex),anchor: .bottom)
        })
    }
}

extension CardStack where Data.Element: Identifiable, ID == Data.Element.ID {
    
    public init(index: Int,
                data: Data,
                @ViewBuilder content: @escaping (Data.Element) -> Content ) {
        self.init(index: index, data: data, id: \Data.Element.id, content: content)
    }
    
}

extension CardStack where Data.Element: Hashable, ID == Data.Element {
    
    public init(index: Int,
                data: Data,
                @ViewBuilder content: @escaping (Data.Element) -> Content ) {
        self.init(index: index, data: data, id: \Data.Element.self, content: content)
    }
    
}


struct CardView<Content: View>: View {
    
    @State private var offset: CGSize = .zero
    private var contentView: () -> Content
    private let swipe: () -> Void
    
    init(onSwipe: @escaping () -> Void,
         @ViewBuilder content: @escaping () -> Content) {
        contentView = content
        swipe = onSwipe
    }
    
    var body: some View {
        GeometryReader{ geo in
            contentView()
                .offset(offset)
                .rotationEffect(.degrees(Double(offset.width/geo.size.width)))
                .gesture(dragGesture(geo))
        }
        .animation(.spring())
    }
    
    private func dragGesture(_ geometry: GeometryProxy) -> some Gesture {
        DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { value in
                offset = value.translation
                
                let threshold = min(geometry.size.width, geometry.size.height) / 2
                let distance = hypot(offset.width, offset.height)
                
                if distance > threshold {
                    withAnimation { swipe()}
                } else {
                    withAnimation { offset = .zero}
                }
            }
    }
}
