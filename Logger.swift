// Created by manny_lopez on 5/14/24.

import Foundation
import os

extension Logger {
  private static var subsystem: String {
    Bundle.main.bundleIdentifier ?? "manny.TinyMoonApp"
  }

  static let statistics = Logger(subsystem: subsystem, category: "statistics")

  static let sessionID = UUID()

  static func log(event: String) {
    let timestamp = Date().description(with: .current)
    let message = """
    \(event)
    timestamp: \(timestamp),
    session: \(sessionID),
    """
    Logger.statistics.debug("\(message)")
  }
}
