// Created by manny_lopez on 4/30/24.

import SwiftUI
import TinyMoon

struct ContentView: View {
  init(date: Date = Date()) {
    moon = TinyMoon().calculateMoonPhase(date)
  }

  @State private var moon: Moon
  @State private var selectedDate = Date()
  @State private var isDatePickerVisible = false

  var body: some View {
    VStack {
      title
        .padding(.top, 8)
      Divider()

      if isDatePickerVisible {
        datePicker
      }

      if !isDatePickerVisible {
        moonDetails

        Divider()
        
        Button {
          NSApplication.shared.terminate(nil)
        } label: {
          Image(systemName: "gearshape")
        }
        .padding(.bottom, 8)
      }
    }
//    .padding()
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
        .padding(2)

      Text(moon.daysTillFullMoon == 0 ? moon.fullMoonName! : "\(moon.daysTillFullMoon) days till next full moon")
        .padding(2)
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
  return ContentView()
}
