// Created by manny_lopez on 5/4/24.

import SwiftUI

struct SettingsView: View {
  @State private var isLaunchAtLogin = false
  @State private var isShowDockIcon = false

  var body: some View {
    VStack {
      title
      Divider()
      launchAtLoginToggleButton
      showDockIconToggleButton
      quitAppButton
      appVersion
      about
      Spacer()
    }
    .padding()
    .frame(width: 350, height: 175) // Set your desired size
    .background(Color.white)
    .cornerRadius(10)
    .shadow(radius: 5)
  }

  private var title: some View {
    Text("Tiny Moon Settings")
      .font(.title2)
  }

  private var launchAtLoginToggleButton: some View {
    HStack {
      Toggle(isOn: $isLaunchAtLogin, label: {})
      .toggleStyle(.switch)
      Text("Launch Tiny Moon at login")
      Spacer()
    }
    .frame(maxWidth: 250)
  }

  private var showDockIconToggleButton: some View {
    HStack {
      Toggle(isOn: $isShowDockIcon, label: {})
      .toggleStyle(.switch)
      Text("Show Dock icon")
      Spacer()
    }
    .frame(maxWidth: 250)
  }

  private var quitAppButton: some View {
    Button("Quit app") {
      NSApplication.shared.terminate(nil)
    }
  }

  private var appVersion: some View {
    Text("version 1.0")
  }

  private var about: some View {
    Text("about")
      .foregroundStyle(.blue)
  }
}

#Preview {
  SettingsView()
}
