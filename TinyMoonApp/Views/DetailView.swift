// Created by manny_lopez on 4/30/24.

import os
import SwiftUI
import TinyMoon

// MARK: - DetailView

struct DetailView: View {

  // MARK: Lifecycle

  init(viewModel: MoonViewModel) {
    self.viewModel = viewModel
    _moon = State(initialValue: viewModel.moon)
    _selectedDate = State(initialValue: viewModel.moon.date)
  }

  // MARK: Internal

  @Environment(\.colorScheme) var colorScheme

  @ObservedObject var viewModel: MoonViewModel

  var body: some View {
    VStack {
      HStack {
        title
        settingsButton
      }
      .padding(.top, 10)

      Divider()
      if isDatePickerVisible {
        datePicker
      }
      if !isDatePickerVisible {
        moonDetails
      }
    }
    .onReceive(viewModel.$moon, perform: { updatedMoon in
      moon = updatedMoon
      selectedDate = updatedMoon.date
    })
    .modifier(OnAppearLogEventViewModifier(event: "DetailView visible: MoonObject: \(moon)"))
  }

  // MARK: Private

  @Environment(\.openWindow) private var openWindow
  @State private var moon: TinyMoon.Moon
  @State private var selectedDate: Date
  @State private var isDatePickerVisible = false

  private var settingsButton: some View {
    Button {
      Logger.log(event: "Settings button tapped")
      openWindow(id: "settings-view")
      NSApplication.shared.activate(ignoringOtherApps: true) // Activate the app and bring the window to the forefront
    } label: {
      Image(systemName: "gearshape")
        .font(.title3)
        .contentShape(Rectangle())
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
            .foregroundStyle(Color("PrimaryTextColor"))
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
      selection: $selectedDate.onChange(applyDateChange),
      displayedComponents: .date)
      .datePickerStyle(GraphicalDatePickerStyle())
      .labelsHidden()
      .padding()
      .modifier(OnAppearLogEventViewModifier(event: "DatePicker visible"))
  }

  private var moonDetails: some View {
    VStack(alignment: .leading, content: {
      Text(moonPhaseText(moon))
        .padding(.top, 4)

      Text(daysTillFullMoon(moon.daysTillFullMoon))
        .padding(.top, 2)

      Text(daysTillNewMoon(moon.daysTillNewMoon))
        .padding(.top, 2)
        .padding(.bottom, 12)
    })
    .font(.title3)
  }

  private var formattedDate: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    return formatter.string(from: selectedDate)
  }

  private func applyDateChange(_ date: Date) {
    selectedDate = date
    moon = TinyMoon.calculateMoonPhase(date)
    Logger.log(event: "DatePicker: New date chosen. MoonObject: \(moon)")
    isDatePickerVisible = false
  }

  private func moonPhaseText(_ moon: TinyMoon.Moon) -> String {
    "\(moon.emoji) \(moon.isFullMoon() ? "Full \(moon.fullMoonName!)" : moon.name)"
  }

  private func daysTillFullMoon(_ daysTillFullMoon: Int) -> String {
    if daysTillFullMoon == 0 {
      ""
    } else if daysTillFullMoon == 1 {
      "\(fullMoonEmoji()) Full moon in 1 day"
    } else {
      "\(fullMoonEmoji()) Full moon in \(daysTillFullMoon) days"
    }
  }

  private func daysTillNewMoon(_ daysTillNewMoon: Int) -> String {
    if daysTillNewMoon == 0 {
      ""
    } else if daysTillNewMoon == 1 {
      "\(newMoonEmoji()) New moon in 1 day"
    } else {
      "\(newMoonEmoji()) New moon in \(daysTillNewMoon) days"
    }
  }

  private func fullMoonEmoji() -> String {
    colorScheme == .light ? "⚪︎" : "⚫︎"
  }

  private func newMoonEmoji() -> String {
    colorScheme == .light ? "⚫︎" : "⚪︎"
  }
}

#Preview {
  let date = Date()
  return DetailView(viewModel: MoonViewModel(date: date))
}

extension Binding {
  func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
    Binding(
      get: { self.wrappedValue },
      set: { selection in
        self.wrappedValue = selection
        handler(selection)
      })
  }
}
