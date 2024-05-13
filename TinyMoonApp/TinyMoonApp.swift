// Created by manny_lopez on 4/30/24.

import SwiftUI
import TinyMoon

@main
struct TinyMoonApp: App {

  init() {
    viewModel = MoonViewModel()
  }

  @ObservedObject var viewModel: MoonViewModel

  var body: some Scene {
    MenuBarExtra(viewModel.moon.emoji) {
      DetailView()
    }
    .menuBarExtraStyle(.window)

    Window("TinyMoon Settings", id: "settings-view") {
      SettingsView()
        .frame(maxWidth: 350, maxHeight: 150)
    }
    .windowResizability(.contentSize)
  }
}
