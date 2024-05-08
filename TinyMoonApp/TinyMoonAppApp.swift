// Created by manny_lopez on 4/30/24.

import SwiftUI
import TinyMoon

@main
struct TinyMoonAppApp: App {
  @State var moon = TinyMoon().calculateMoonPhase()
  var body: some Scene {
    MenuBarExtra(moon.emoji) {
      DetailView()
    }
    .menuBarExtraStyle(.window)

    WindowGroup(id: "settings-view") {
      SettingsView()
        .frame(maxWidth: 350, maxHeight: 150)
    }
    .windowResizability(.contentSize)
  }
}
