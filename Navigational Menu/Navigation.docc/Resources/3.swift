import SwiftUI
import Combine
import Foundation

struct ExperimentMenuItem: Identifiable {
    var id = UUID()
    var text: String
    var iconName: String
}

var experimentMenuItems = [
    ExperimentMenuItem(text: "Home", iconName: "house.fill"),
    ExperimentMenuItem(text: "Search", iconName: "magnifyingglass"),
    ExperimentMenuItem(text: "Favorites", iconName: "star.fill"),
    ExperimentMenuItem(text: "Help", iconName: "questionmark.circle.fill")
]

struct ExperimentMenuRow: View {
    var item: ExperimentMenuItem

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: item.iconName)
                .frame(width: 32, height: 32)
                .opacity(0.6)
            Text(item.text)
                .customFont(.headline)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "17203A").opacity(0.2))
        .cornerRadius(8)
        .onTapGesture {
            // Add any action here if needed
        }
    }
}

struct ExperimentMenuRow_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentMenuRow(item: experimentMenuItems[0])
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray)
    }
}

struct ExperimentHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "person")
                .padding(12)
                .background(Color.white.opacity(0.2))
                .mask(Circle())
            VStack(alignment: .leading, spacing: 2) {
                Text("Meng To")
                    .customFont(.body)
                Text("UI Designer")
                    .customFont(.subheadline)
                    .opacity(0.7)
            }
            Spacer()
        }
        .padding()
        .foregroundColor(.white)
        .background(Color(hex: "17203A"))
        .cornerRadius(30)
    }
}

struct ExperimentHeader_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentHeader()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray)
    }
}

struct ExperimentMainMenu: View {
    var body: some View {
        VStack(spacing: 0) {
            ExperimentHeader()
                .frame(maxWidth: 288)
                .background(Color(hex: "17203A"))
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .padding(.bottom)

            Text("BROWSE")
                .customFont(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 40)
                .opacity(0.7)

            VStack(alignment: .leading, spacing: 0) {
                ForEach(experimentMenuItems) { item in
                    ExperimentMenuRow(item: item)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                }
            }
            .padding(.top)
        }
        .foregroundColor(.white)
        .background(Color(hex: "17203A"))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ExperimentMainMenu_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentMainMenu()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff

        self.init(
            .sRGB,
            red: Double(red) / 0xff,
            green: Double(green) / 0xff,
            blue: Double(blue) / 0xff,
            opacity: 1
        )
    }
}
