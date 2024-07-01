import SwiftUI

struct FullHeightDrawerMenu<Content: View>: View {
    @Binding var isOpen: Bool
    let menuWidth: CGFloat
    let content: Content

    init(isOpen: Binding<Bool>, menuWidth: CGFloat = 300, @ViewBuilder content: () -> Content) {
        self._isOpen = isOpen
        self.menuWidth = menuWidth
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .leading) {
            if isOpen {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            self.isOpen = false
                        }
                    }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    self.content
                }
                .frame(width: menuWidth)
                .background(Color.white)
                .offset(x: isOpen ? 0 : -menuWidth)
                .animation(.default, value: isOpen)

                Spacer()
            }
        }
    }
}

struct FullHeightContentView: View {
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

            FullHeightDrawerMenu(isOpen: $isDrawerOpen) {
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

struct FullHeightContentView_Previews: PreviewProvider {
    static var previews: some View {
        FullHeightContentView()
    }
}
import SwiftUI

struct BottomDrawerMenu<Content: View>: View {
    @Binding var isOpen: Bool
    let menuHeight: CGFloat
    let content: Content

    init(isOpen: Binding<Bool>, menuHeight: CGFloat = 300, @ViewBuilder content: () -> Content) {
        self._isOpen = isOpen
        self.menuHeight = menuHeight
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            if isOpen {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            self.isOpen = false
                        }
                    }
            }
            
            VStack {
                Spacer()

                VStack(alignment: .leading) {
                    self.content
                }
                .frame(height: menuHeight)
                .background(Color.white)
                .cornerRadius(15)
                .offset(y: isOpen ? 0 : menuHeight)
                .animation(.default, value: isOpen)
            }
        }
    }
}

struct BottomDrawerContentView: View {
    @State private var isDrawerOpen = false

    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    withAnimation {
                        self.isDrawerOpen.toggle()
                    }
                }) {
                    Text("Open Bottom Drawer")
                }
            }

            BottomDrawerMenu(isOpen: $isDrawerOpen) {
                VStack(alignment: .leading) {
                    Button(action: {
                        // Handle menu item action
                    }) {
                        Text("Bottom Menu Item 1")
                    }
                    .padding()

                    Button(action: {
                        // Handle menu item action
                    }) {
                        Text("Bottom Menu Item 2")
                    }
                    .padding()

                    Button(action: {
                        // Handle menu item action
                    }) {
                        Text("Bottom Menu Item 3")
                    }
                    .padding()
                }
            }
        }
    }
}

struct BottomDrawerContentView_Previews: PreviewProvider {
    static var previews: some View {
        BottomDrawerContentView()
    }
}
