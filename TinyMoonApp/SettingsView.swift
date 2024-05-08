// Created by manny_lopez on 5/4/24.

import SwiftUI
import LaunchAtLogin

struct SettingsView: View {
  @State private var isLaunchAtLogin = false
  @State private var isShowDockIcon = false

  var body: some View {
    VStack {
      HStack {
        appVersion
        Spacer()
        about
      }
      title
      Divider()
      launchAtLoginToggleButton
      quitAppButton
        .padding(.top, 4)
      Spacer()
    }
    .padding()
    .background(Color.white)
    .cornerRadius(10)
    .shadow(radius: 5)
  }

  private var title: some View {
    Text("Tiny Moon Settings")
      .font(.title2)
  }

  private var quitAppButton: some View {
    Button("Quit app") {
      NSApplication.shared.terminate(nil)
    }
  }

  private var appVersion: some View {
    Text("Version 1.0")
  }

  private var about: some View {
    Text("Info")
      .foregroundStyle(.blue)
  }

  private var launchAtLoginToggleButton: some View {
    LaunchAtLogin.Toggle()
      .toggleStyle(.switch)
      .padding(.top, 4)
  }
}


#Preview {
  SettingsView()
}
