import SwiftUI
//
//
//Drawer Menu (Side Navigation): Similar to the hamburger menu, a drawer menu slides in from the side but often with a more complex structure, including sections, headers, and even footers.
//
//
struct DrawerMenu<Content: View>: View {
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

