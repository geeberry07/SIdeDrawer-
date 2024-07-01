import SwiftUI
import Combine
import Foundation
       
// Menu Item Struct and Data:

struct SampleMenuItem: Identifiable {
    var id = UUID()
    var text: String
    var iconName: String
    var menu: SampleSelectedMenu
}

enum SampleSelectedMenu: String {
    case home, search, favorites, help, history, notifications, darkmode
}

var SampleMenuItems = [
    SampleMenuItem(text: "Home", iconName: "house.fill", menu: .home),
    SampleMenuItem(text: "Search", iconName: "magnifyingglass", menu: .search),
    SampleMenuItem(text: "Favorites", iconName: "star.fill", menu: .favorites),
    SampleMenuItem(text: "Help", iconName: "questionmark.circle.fill", menu: .help)
]

var SampleMenuItems2 = [
    SampleMenuItem(text: "History", iconName: "clock.fill", menu: .history),
    SampleMenuItem(text: "Notifications", iconName: "bell.fill", menu: .notifications)
]

var SampleMenuItems3 = [
    SampleMenuItem(text: "Dark Mode", iconName: "moon.fill", menu: .darkmode)
]
// Menu Row Component:
struct SampleMenuRow: View {
    var item: SampleMenuItem
    @Binding var selectedMenu: SampleSelectedMenu

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

struct SampleMenuRow_Previews: PreviewProvider {
    static var previews: some View {
        SampleMenuRow(item: SampleMenuItems[0], selectedMenu: .constant(.home))
    }
}
// Side Menu Component:

struct SampleSideMenu: View {
    @Binding var selectedMenu: SampleSelectedMenu
    @Binding var isDarkMode: Bool

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(SampleMenuItems) { item in
                SampleMenuRow(item: item, selectedMenu: $selectedMenu)
            }

            Text("HISTORY")
                .customFont(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 40)
                .opacity(0.7)

            VStack(alignment: .leading, spacing: 0) {
                ForEach(SampleMenuItems2) { item in
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.1)
                        .padding(.horizontal, 16)

                    SampleMenuRow(item: item, selectedMenu: $selectedMenu)
                }
            }
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)

            HStack {
                Image(systemName: SampleMenuItems3[0].iconName)
                    .frame(width: 32, height: 32)
                    .opacity(0.6)
                Text(SampleMenuItems3[0].text)
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

struct SampleSideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SampleSideMenu(selectedMenu: .constant(.home), isDarkMode: .constant(false))
    }
}
// Tab Bar Component:

struct SampleTabBar: View {
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

struct SampleTabBar_Previews: PreviewProvider {
    static var previews: some View {
        SampleTabBar()
    }
}
// Main Content View:

struct SampleContentView: View {
    @State private var isOpen = false
    @State var selectedMenu: SampleSelectedMenu = .home
    @State var isDarkMode = false

    var body: some View {
        ZStack {
            // Background color
            Color("BackgroundColor").ignoresSafeArea()

            // Side Menu
            SampleSideMenu(selectedMenu: $selectedMenu, isDarkMode: $isDarkMode)
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
                SampleTabBar()
                    .offset(y: isOpen ? 300 : 0)
            }
        }
    }
}

struct SampleContentView_Previews: PreviewProvider {
    static var previews: some View {
        SampleContentView()
    }
}
