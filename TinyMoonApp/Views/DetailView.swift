// Created by manny_lopez on 4/30/24.

import os
import SwiftUI
import TinyMoon

struct DetailView: View {

  init(date: Date = Date()) {
    moon = TinyMoon().calculateMoonPhase(date)
  }

  @Environment(\.openWindow) private var openWindow

  @State private var moon: Moon
  @State private var selectedDate = Date()
  @State private var isDatePickerVisible = false

  var body: some View {
    HStack {
      title
      settingsButton
    }
    .modifier(OnAppearLogEventViewModifier(event: "DetailView visible: MoonObject: \(moon), daysTillFullMoon: \(daysTillFullMoon(moon.daysTillFullMoon))"))
    .padding(.top, 10)

    VStack {
      Divider()
      if isDatePickerVisible {
        datePicker
      }
      if !isDatePickerVisible {
        moonDetails
      }
    }
  }

  private var settingsButton: some View {
    Button {
      Logger.log(event: "Settings button tapped")
      openWindow(id: "settings-view")
      NSApplication.shared.activate(ignoringOtherApps: true) // Activate the app and bring the window to the forefront
    } label: {
      Image(systemName: "gearshape")
        .font(.title3)
    }
    .buttonStyle(PlainButtonStyle())
    .onAppear {
      // Set focus to nil to remove focus from the settings button
      DispatchQueue.main.async {
        NSApplication.shared.keyWindow?.makeFirstResponder(nil)
      }
    }
  }

  private var title: some View {
    Group {
      HStack {
        Text("Moon status for")
        Button(action: {
          isDatePickerVisible.toggle()
        }, label: {
          Text(formattedDate)
            .onAppear {
              // Set focus to nil to remove focus from the settings button
              DispatchQueue.main.async {
                NSApplication.shared.keyWindow?.makeFirstResponder(nil)
              }
            }
        })
        .offset(x: -2)
      }
    }
    .font(.title2)
    .padding(.leading, 30)
  }

  private var datePicker: some View {
    DatePicker(
      "",
      selection: $selectedDate,
      displayedComponents: .date
    )
    .datePickerStyle(GraphicalDatePickerStyle())
    .labelsHidden()
    .padding()
    .onChange(of: selectedDate) { _, newValue in
      selectedDate = newValue
      moon = TinyMoon().calculateMoonPhase(newValue)
      Logger.log(event: "DatePicker: New date chosen. MoonObject: \(moon)")
      isDatePickerVisible = false
    }
    .modifier(OnAppearLogEventViewModifier(event: "DatePicker visible"))
  }

  private var moonDetails: some View {
    VStack(alignment: .leading, content: {
      Text("\(moon.emoji) \(moon.name)")
        .padding(.top, 4)

      Text(daysTillFullMoon(moon.daysTillFullMoon))
        .padding(.top, 2)
        .padding(.bottom, 12)
    })
    .font(.title3)
  }

  private var formattedDate: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    let formattedDate = formatter.string(from: selectedDate)
    return formattedDate
  }

  private func daysTillFullMoon(_ daysTillFullMoon: Int) -> String {
    daysTillFullMoon == 0 ? moon.fullMoonName! : "\(moon.daysTillFullMoon) days till next full moon"
  }
}

#Preview {
  return DetailView()
}
