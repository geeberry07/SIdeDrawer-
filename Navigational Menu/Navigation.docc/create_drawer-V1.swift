import SwiftUI

struct StandardDrawer: View {
    @State private var isDrawerOpen = false

    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    withAnimation {
                        self.isDrawerOpen.toggle()
                    }
                }) {
                    Text("Open Drawer")
                }
            }

            DrawerMenu(isOpen: $isDrawerOpen) {
                VStack(alignment: .leading) {
                    Button(action: {
                        // Handle menu item action
                    }) {
                        Text("Menu Item 1")
                    }
                    .padding()

                    Button(action: {
                        // Handle menu item action
                    }) {
                        Text("Menu Item 2")
                    }
                    .padding()

                    Button(action: {
                        // Handle menu item action
                    }) {
                        Text("Menu Item 3")
                    }
                    .padding()
                }
            }
        }
    }
}

struct StandardDrawer_Previews: PreviewProvider {
    static var previews: some View {
        StandardDrawer()
    }
}
