//
//  GRID_Data_CSGoApp.swift
//  GRID Data CSGo
//
//  Created by Babatunde Onabajo on 13/09/2023.
//

import SwiftUI

@main
struct GRID_Data_CSGoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
