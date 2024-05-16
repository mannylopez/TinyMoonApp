// Created by manny_lopez on 5/14/24.

import Foundation
import OSLog

extension Logger {
  private static var subsystem: String {
    Bundle.main.bundleIdentifier ?? "manny.TinyMoonApp"
  }

  private static let statistics = Logger(subsystem: subsystem, category: "statistics")

  private static let sessionID = UUID()

  private(set) static var logEntries: [EntryMetadata] = []

  static func log(event: String) {
    Logger.statistics.info("\(event , privacy: .public)")
  }

  private static func formatLog(_ log: OSLogEntryLog) -> EntryMetadata {
    EntryMetadata(
      timestamp: log.date.description(with: .current),
      category: log.category,
      message: log.composedMessage,
      sessionID: sessionID)
  }

  static func export() {
    do {
      let store = try OSLogStore(scope: .currentProcessIdentifier)
      let position = store.position(timeIntervalSinceLatestBoot: 1)
      logEntries = try store
        .getEntries(at: position)
        .compactMap { $0 as? OSLogEntryLog }
        .filter { $0.subsystem == subsystem }
        .map { formatLog($0) }
    } catch {
      Logger.statistics.debug("Error: \(error.localizedDescription)")
    }
  }
}
