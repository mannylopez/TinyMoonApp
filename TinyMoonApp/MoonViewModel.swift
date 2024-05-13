// Created by manny_lopez on 5/13/24.

import Foundation
import SwiftUI
import TinyMoon

class MoonViewModel: ObservableObject {
  var moon: Moon

  init(date: Date = Date()) {
    self.moon = TinyMoon().calculateMoonPhase(date)
  }
}
