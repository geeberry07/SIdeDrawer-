import SwiftUI

struct ExampleMenuItem: Identifiable {
    var id = UUID()
    var text: String
    var iconName: String
    var menu: ExampleSelectedMenu
}

enum ExampleSelectedMenu: String {
    case home, search, favorites, help, history, notifications, darkmode
}

var exampleMenuItems = [
    ExampleMenuItem(text: "Home", iconName: "house.fill", menu: .home),
    ExampleMenuItem(text: "Search", iconName: "magnifyingglass", menu: .search),
    ExampleMenuItem(text: "Favorites", iconName: "star.fill", menu: .favorites),
    ExampleMenuItem(text: "Help", iconName: "questionmark.circle.fill", menu: .help)
]

var exampleMenuItems2 = [
    ExampleMenuItem(text: "History", iconName: "clock.fill", menu: .history),
    ExampleMenuItem(text: "Notifications", iconName: "bell.fill", menu: .notifications)
]

var exampleMenuItems3 = [
    ExampleMenuItem(text: "Dark Mode", iconName: "moon.fill", menu: .darkmode)
]

struct ExampleMenuRow: View {
    var item: ExampleMenuItem
    @Binding var selectedMenu: ExampleSelectedMenu

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

struct ExampleMenuRow_Previews: PreviewProvider {
    static var previews: some View {
        ExampleMenuRow(item: exampleMenuItems[0], selectedMenu: .constant(.home))
    }
}
import SwiftUI

struct ExampleContentView: View {
    @State private var isOpen = false
    @State var selectedMenu: ExampleSelectedMenu = .home
    @State var isDarkMode = false

    var body: some View {
        ZStack {
            // Background color
            Color("17203A").ignoresSafeArea()

            // Side Menu
            ExampleSideMenu(selectedMenu: $selectedMenu, isDarkMode: $isDarkMode)
                .opacity(isOpen ? 1 : 0)
                .offset(x: isOpen ? 0 : -300)
                .rotation3DEffect(.degrees(isOpen ? 0 : 30), axis: (x: 0, y: 1, z: 0))

            // Main View
            VStack {
                HStack {
                    Button(action: {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                            isOpen.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding()
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
            .background(Color.white)
            .mask(RoundedRectangle(cornerRadius: isOpen ? 30 : 0, style: .continuous))
            .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0, y: -1, z: 0))
            .offset(x: isOpen ? 265 : 0)
            .scaleEffect(isOpen ? 0.9 : 1)
            .ignoresSafeArea()

            // Tab Bar
            VStack {
                Spacer()
                ExampleTabBar()
                    .offset(y: isOpen ? 300 : 0)
            }
        }
    }
}

struct ExampleTabBar: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "house.fill")
            Spacer()
            Image(systemName: "magnifyingglass")
            Spacer()
            Image(systemName: "star.fill")
            Spacer()
            Image(systemName: "questionmark.circle.fill")
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 10)
    }
}
struct ExampleSideMenu: View {
    @Binding var selectedMenu: ExampleSelectedMenu
    @Binding var isDarkMode: Bool

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(exampleMenuItems) { item in
                ExampleMenuRow(item: item, selectedMenu: $selectedMenu)
            }

            Text("HISTORY")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 40)
                .opacity(0.7)

            VStack(alignment: .leading, spacing: 0) {
                ForEach(exampleMenuItems2) { item in
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.1)
                        .padding(.horizontal, 16)

                    ExampleMenuRow(item: item, selectedMenu: $selectedMenu)
                }
            }
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)

            HStack {
                Image(systemName: exampleMenuItems3[0].iconName)
                    .frame(width: 32, height: 32)
                    .opacity(0.6)
                Text(exampleMenuItems3[0].text)
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

struct ExampleSideMenu_Previews: PreviewProvider {
    static var previews: some View {
        ExampleSideMenu(selectedMenu: .constant(.home), isDarkMode: .constant(false))
    }
}
struct ExampleTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ExampleTabBar()
    }
}
struct ExampleContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleContentView()
    }
}

