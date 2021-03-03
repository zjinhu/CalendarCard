import SwiftUI

struct BottomBar : View {
    @Binding public var selectedIndex: Int
    
    let items: [BottomBarItem]
    
    init(selectedIndex: Binding<Int>, items: [BottomBarItem]) {
        self._selectedIndex = selectedIndex
        self.items = items
    }
    
    func itemView(at index: Int) -> some View {
        Button(action: {
            withAnimation { self.selectedIndex = index }
        }) {
            BottomBarItemView(isSelected: index == selectedIndex, item: items[index])
                .frame(maxWidth: .infinity)
        }
        
    }
    
    var body: some View {
        ZStack {
            BlurView(style: .systemUltraThinMaterialLight)
            HStack(alignment: .center) {
                self.itemView(at: 0)
                
                self.itemView(at: 1)
            }
            .padding([.horizontal])
            .animation(.default)
        }
        .frame(height: 40.0)
    }
}

struct BottomBar_Previews : PreviewProvider {
    static var previews: some View {
        BottomBar(selectedIndex: .constant(0), items: [
            BottomBarItem(icon: "house.fill", title: "首页", color: .purple),
            BottomBarItem(icon: "heart", title: "提醒", color: .pink)
        ])
        .previewLayout(.sizeThatFits)
    }
}

struct BottomBarItem {
    let icon: String
    let title: String
    let color: Color
    
    init(icon: String,
         title: String,
         color: Color) {
        self.icon = icon
        self.title = title
        self.color = color
    }
}

struct BottomBarItemView: View {
    let isSelected: Bool
    let item: BottomBarItem
    
    var body: some View {
        VStack {
            Image(systemName: item.icon)
                .imageScale(.small)
                .foregroundColor(isSelected ? item.color : Color.orange)
            
            Text(item.title)
                .font(.caption2)
                .foregroundColor(isSelected ? item.color : Color.orange)
        }
    }
}


struct BlurView: UIViewRepresentable {

    let style: UIBlurEffect.Style

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }

    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {

    }
}
