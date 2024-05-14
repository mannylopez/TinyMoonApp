// Created by manny_lopez on 5/14/24.

import Foundation

struct EntryMetadata: CustomDebugStringConvertible {
  let timestamp: String
  let category: String
  let message: String
  let sessionID: UUID

  var debugDescription: String {
    """

      {
        "timestamp": \(timestamp),
        "category": \(category),
        "sessionID": \(sessionID),
        "message": \(message)
      }
    """
  }
}
