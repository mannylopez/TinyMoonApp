// Created by manny_lopez on 5/13/24.

import Foundation
import os
import SwiftUI
import TinyMoon

class MoonViewModel: ObservableObject {
  public static let appVersion = "v. 1.0"

  @Published var moon: Moon

  init(date: Date = Date()) {
    self.moon = TinyMoon().calculateMoonPhase(date)
    Logger.log(event: "MoonViewModel initialized")
  }
}
