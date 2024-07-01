import SwiftUI
// **RoundedCorner.swif**

// **Step 1**: Create a Custom RoundedCorner Shape
//  *This shape will allow you to round only the specified corners of a rectangle.

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// **Step 2**: Create a View Modifier
// *To easily apply the RoundedCorner shape to any view, create an extension for View.
// ** View+CornerRadius.swift**

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// **Step 3**: Update Your CustomContentView
// *Use the custom modifier to apply rounded corners to your views.
// **CustomContentView.swift**
import SwiftUI

struct CustomMenuItem: Identifiable {
    var id = UUID()
    var text: String
    var iconName: String
    var menu: CustomSelectedMenu
}

enum CustomSelectedMenu: String {
    case home, search, favorites, help, history, notifications, darkmode
}

var customMenuItems = [
    CustomMenuItem(text: "Home", iconName: "house.fill", menu: .home),
    CustomMenuItem(text: "Search", iconName: "magnifyingglass", menu: .search),
    CustomMenuItem(text: "Favorites", iconName: "star.fill", menu: .favorites),
    CustomMenuItem(text: "Help", iconName: "questionmark.circle.fill", menu: .help)
]

var customMenuItems2 = [
    CustomMenuItem(text: "History", iconName: "clock.fill", menu: .history),
    CustomMenuItem(text: "Notifications", iconName: "bell.fill", menu: .notifications)
]

var customMenuItems3 = [
    CustomMenuItem(text: "Dark Mode", iconName: "moon.fill", menu: .darkmode)
]

struct CustomMenuRow: View {
    var item: CustomMenuItem
    @Binding var selectedMenu: CustomSelectedMenu

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

struct CustomMenuRow_Previews: PreviewProvider {
    static var previews: some View {
        CustomMenuRow(item: customMenuItems[0], selectedMenu: .constant(.home))
    }
}

struct CustomSideMenu: View {
    @Binding var selectedMenu: CustomSelectedMenu
    @Binding var isDarkMode: Bool

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(customMenuItems) { item in
                CustomMenuRow(item: item, selectedMenu: $selectedMenu)
            }

            Text("HISTORY")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 40)
                .opacity(0.7)

            VStack(alignment: .leading, spacing: 0) {
                ForEach(customMenuItems2) { item in
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.1)
                        .padding(.horizontal, 16)

                    CustomMenuRow(item: item, selectedMenu: $selectedMenu)
                }
            }
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)

            HStack {
                Image(systemName: customMenuItems3[0].iconName)
                    .frame(width: 32, height: 32)
                    .opacity(0.6)
                Text(customMenuItems3[0].text)
                    .font(.headline)

                Toggle("", isOn: $isDarkMode)
                    .onChange(of: isDarkMode) { newValue in
                        // Add any additional actions for dark mode toggle here
                    }
            }
            .padding(20)
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.5), radius: 20, x: 10, y: 10)
    }
}

struct CustomSideMenu_Previews: PreviewProvider {
    static var previews: some View {
        CustomSideMenu(selectedMenu: .constant(.home), isDarkMode: .constant(false))
    }
}

struct CustomTabBar: View {
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
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
        )
        .cornerRadius(30)
        .shadow(radius: 10)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}

struct MainMessageView: View {
    @State private var message: String = ""

    var body: some View {
        VStack {
            // AI Avatar
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                Text("AI Assistant")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 8)
            }
            .padding(.top, 40)

            // Sample Card Topics
            VStack(spacing: 20) {
                Text("Sample Topics")
                    .font(.headline)
                    .padding(.top, 20)
                ForEach(0..<3) { index in
                    CardView(topic: "Sample Topic \(index + 1)")
                }
            }
            .padding(.top, 20)

            Spacer()

            // Send Message Option
            HStack {
                TextField("Type a message...", text: $message)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.leading)

                Button(action: {
                    // Handle send message action
                }) {
                    Text("Send")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.trailing)
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 10)
        .padding(.horizontal)
    }
}

struct CardView: View {
    var topic: String

    var body: some View {
        VStack {
            Text(topic)
                .font(.headline)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct MainMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessageView()
    }
}

struct CustomContentView: View {
    @State private var isOpen = false
    @State var selectedMenu: CustomSelectedMenu = .home
    @State var isDarkMode = false
@State private var isTabBarHidden = true // New state variable to control tab bar visibility

var body: some View {
    ZStack {
        // Background color
        Color(hex: ]"17203A").ignoresSafeArea()

        // Side Menu
        CustomSideMenu(selectedMenu: $selectedMenu, isDarkMode: $isDarkMode)
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
            MainMessageView()
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(isOpen ? 30 : 0, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
        .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0, y: -1, z: 0))
        .offset(x: isOpen ? 265 : 0)
        .scaleEffect(isOpen ? 0.9 : 1)
        .shadow(color: Color.black.opacity(isOpen ? 0.5 : 0), radius: 20, x: 0, y: 20)
        .ignoresSafeArea()

        // Tab Bar
        if !isTabBarHidden {
            VStack {
                Spacer()
                CustomTabBar()
                    .offset(y: isOpen ? 300 : 0)
            }
        }
    }
}
}

struct CustomContentView_Previews: PreviewProvider {
static var previews: some View {
CustomContentView()
}
}

/*
### Summary
- **`RoundedCorner` Shape**: Allows for specifying which corners to round and by how much.
- **Custom View Modifier**: Easily applies the `RoundedCorner` shape to any view.
- **Enhanced Visuals**: Uses shadows, gradients, and animations to create a more dynamic and 3D-like appearance for the drawer system.

This approach gives you complete control over the appearance and behavior of rounded corners in your SwiftUI views, without cutting any corners in the implementation.
*/
