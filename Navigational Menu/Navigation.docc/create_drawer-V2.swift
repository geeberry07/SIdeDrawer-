import SwiftUI
import Combine
import Foundation

struct MenuItem: Identifiable {
    var id = UUID()
    var text: String
    var iconName: String
    var menu: SelectedMenu
}

enum SelectedMenu: String {
    case home, search, favorites, help, history, notifications, darkmode
}
//Create Menu Items:
var menuItems = [
    MenuItem(text: "Home", iconName: "house.fill", menu: .home),
    MenuItem(text: "Search", iconName: "magnifyingglass", menu: .search),
    MenuItem(text: "Favorites", iconName: "star.fill", menu: .favorites),
    MenuItem(text: "Help", iconName: "questionmark.circle.fill", menu: .help)
]

var menuItems2 = [
    MenuItem(text: "History", iconName: "clock.fill", menu: .history),
    MenuItem(text: "Notifications", iconName: "bell.fill", menu: .notifications)
]

var menuItems3 = [
    MenuItem(text: "Dark Mode", iconName: "moon.fill", menu: .darkmode)
    ]
    
struct MenuRow: View {
    var item: MenuItem
    @Binding var selectedMenu: SelectedMenu

    var body: some View {
        HStack {
            Image(systemName: item.iconName)
                .frame(width: 32, height: 32)
                .opacity(selectedMenu == item.menu ? 1 : 0.6)
                .foregroundColor(selectedMenu == item.menu ? .white : .primary)
            Text(item.text)
                .font(.headline)
                .foregroundColor(selectedMenu == item.menu ? .white : .primary)
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(selectedMenu == item.menu ? Color.blue : Color.clear)
        )
        .onTapGesture {
            withAnimation(.timingCurve(0.2, 0.8, 0.2, 1)) {
                selectedMenu = item.menu
            }
        }
    }
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        MenuRow(item: menuItems[0], selectedMenu: .constant(.home))
    }
}
// Side Menu Implementation:
struct SideMenu: View {
    @State var selectedMenu: SelectedMenu = .home
    @State var isDarkMode = false

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(menuItems) { item in
                MenuRow(item: item, selectedMenu: $selectedMenu)
            }

            Text("HISTORY")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 40)
                .opacity(0.7)

            VStack(alignment: .leading, spacing: 0) {
                ForEach(menuItems2) { item in
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.1)
                        .padding(.horizontal, 16)

                    MenuRow(item: item, selectedMenu: $selectedMenu)
                }
            }
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)

            HStack {
                Image(systemName: menuItems3[0].iconName)
                    .frame(width: 32, height: 32)
                    .opacity(0.6)
                Text(menuItems3[0].text)
                    .font(.headline)

                Toggle("", isOn: $isDarkMode)
                    .onChange(of: isDarkMode) { newValue in
                        // Add any additional actions for dark mode toggle here
                    }
            }
            .padding(20)
        }
        .padding()
        .background(Color("Background 2"))
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}
extension Text {
    func customFont(_ style: Font.TextStyle) -> some View {
        self.font(.custom("YourCustomFontName", size: style == .headline ? 17 : 14))
    }
}
