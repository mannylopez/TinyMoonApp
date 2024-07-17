// Created by manny_lopez on 5/13/24.

import Foundation
import os
import SwiftUI
import TinyMoon

class MoonViewModel: ObservableObject {
  public static let appVersion = "v. 1.0"

  @Published var moon: TinyMoon.Moon

  init(date: Date = Date()) {
    self.moon = TinyMoon.calculateMoonPhase(date)
    startBackgroundTask()
    Logger.log(event: "MoonViewModel initialized with MoonObject: \(moon)")
  }

  private func startBackgroundTask() {
    Logger.log(event: "BackgroundTask started")
    let activity = NSBackgroundActivityScheduler(identifier: "com.manny.TinyMoonApp.updatecheck")
    activity.invalidate()
    activity.interval = 60 * 10 // Once every 10 minutes
    activity.repeats = true
    activity.qualityOfService = .utility
    activity.schedule() { (completion: NSBackgroundActivityScheduler.CompletionHandler) in
      DispatchQueue.main.async {
        let now = Date()
        Logger.log(event: "NSBackgroundActivityScheduler: Inside BackgroundActivity completion handler. fullMoonDate: \(now)")
        self.moon = TinyMoon.calculateMoonPhase(now)
        Logger.log(event: "NSBackgroundActivityScheduler: New MoonObject: \(self.moon)")
      }

      completion(NSBackgroundActivityScheduler.Result.finished)
    }
  }

}
