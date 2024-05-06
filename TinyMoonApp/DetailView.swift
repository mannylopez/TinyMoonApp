// Created by manny_lopez on 4/30/24.

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
      Spacer()
      settingsButton
    }
    VStack {
      title
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
      openWindow(id: "settings-view")
    } label: {
      Image(systemName: "gearshape")
    }
    .buttonStyle(PlainButtonStyle())
    .padding(.top, 8)
    .padding(.trailing, 8)
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
        })
        .offset(x: -3)
      }
    }
    .font(.title2)
    .padding(.top, -20)
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
      isDatePickerVisible = false
    }
  }

  private var moonDetails: some View {
    VStack(alignment: .leading, content: {
      Text("\(moon.emoji) \(moon.name)")
        .padding(.top, 4)

      Text(moon.daysTillFullMoon == 0 ? moon.fullMoonName! : "\(moon.daysTillFullMoon) days till next full moon")
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
}

#Preview {
  return DetailView()
}
