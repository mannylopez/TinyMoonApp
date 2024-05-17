// Created by manny_lopez on 5/4/24.

import os
import SwiftUI
import LaunchAtLogin

struct SettingsView: View {
  @State private var showDebugLogs = false
  @State private var exportLogs = false
  private var document: TextDocument {
    TextDocument(text: Logger.logEntries.debugDescription)
  }

  var body: some View {
    VStack {
      HStack {
        appVersion
        Spacer()
        about
      }
      title
      Divider()
      if !showDebugLogs {
        launchAtLoginToggleButton
        showDebugLogsButton
        quitAppButton
      }
      else {
        debugLogsView
      }
      Spacer()
    }
    .modifier(OnAppearLogEventViewModifier(event: "SettingsView on screen"))
    .padding()
    .background(Color("BackgroundColor"))
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
    .padding(.top, 4)
  }

  private var appVersion: some View {
    Text(MoonViewModel.appVersion)
  }

  @ViewBuilder
  private var about: some View {
    Link("Contact", destination: URL(string: "https://github.com/mannylopez/TinyMoonApp/issues/21") ?? URL(string: "mailto:TinyMoonApp@gmail.com")!)
      .onAppear {
        // Set focus to nil to remove focus from the settings button
        DispatchQueue.main.async {
          NSApplication.shared.keyWindow?.makeFirstResponder(nil)
        }
      }
  }

  private var launchAtLoginToggleButton: some View {
    LaunchAtLogin.Toggle()
      .toggleStyle(.switch)
      .padding(.top, 4)
  }

  private var showDebugLogsButton: some View {
    Button("Show debug logs") {
      Logger.log(event: "Show debug logs button tapped")
      Logger.export()
      showDebugLogs = true
    }
    .padding(.top, 4)
  }

  private var exportLogsButton: some View {
    Button("Export") {
      Logger.log(event: "Export logs button tapped")
      Logger.export()
      exportLogs = true
    }
    .fileExporter(
      isPresented: $exportLogs,
      document: document,
      contentType: .plainText,
      defaultFilename: "tinyMoonDebugLogs.txt"
    ) { result in
      switch result {
      case .success(let file):
        print(file)
      case .failure(let error):
        print(error)
      }
    }
  }

  @ViewBuilder
  private var debugLogsView: some View {
    HStack {
      Button("Back") {
        showDebugLogs = false
      }
      exportLogsButton
    }
    ScrollView {
      Text(Logger.logEntries.debugDescription)
        .padding()
        .lineLimit(nil)
    }
    .modifier(RoundedRectangleBorder())
    .frame(maxHeight: .infinity)
  }
}

#Preview {
  SettingsView()
}
