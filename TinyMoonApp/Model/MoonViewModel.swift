// Created by manny_lopez on 5/13/24.

import Foundation
import os
import SwiftUI
import TinyMoon

class MoonViewModel: ObservableObject {
  public static let appVersion = "v. 1.0"

  @Published var moon: Moon

  init(date: Date = Date()) {
    self.moon = TinyMoon.calculateMoonPhase(date)
    startBackgroundTask()
    Logger.log(event: "MoonViewModel initialized with MoonObject: \(moon), daysTillFullMoon: \(moon.daysTillFullMoon)")
  }

  private func startBackgroundTask() {
    Logger.log(event: "BackgroundTask started")
    let activity = NSBackgroundActivityScheduler(identifier: "com.manny.TinyMoonApp.updatecheck")
    activity.invalidate()
    activity.interval = 60
    activity.repeats = true
    activity.qualityOfService = .utility
    activity.schedule() { (completion: NSBackgroundActivityScheduler.CompletionHandler) in
      DispatchQueue.main.async {
        let randomDay = Int.random(in: 1...28)
        Logger.log(event: "NSBackgroundActivityScheduler: Inside BackgroundActivity completion handler. RandomDay: \(randomDay)")
        let fullMoonDate = Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: randomDay))
        self.moon = TinyMoon.calculateMoonPhase(fullMoonDate!) // Update this
        Logger.log(event: "NSBackgroundActivityScheduler: New MoonObject: \(self.moon)")
      }

      completion(NSBackgroundActivityScheduler.Result.finished)
    }
  }

}
