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
      DetailView(viewModel: viewModel)
    }
    .menuBarExtraStyle(.window)

    Window("TinyMoon Settings", id: "settings-view") {
      SettingsView()
        .frame(minWidth: 400, minHeight: 200)
    }
    .windowResizability(.contentSize)
  }
}
