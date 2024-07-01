//
//  SIdeDrawer_App.swift
//  SIdeDrawer[
//
//  Created by garyberry09 on 6/30/24.
//

import SwiftUI
import UIKit
import Foundation
import Combine

@main
struct NavigationDrawer: App {
    

    var body: some Scene {
        WindowGroup {
           CustomContentView()
        }
    }
}
struct NContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomContentView()

    }
}
