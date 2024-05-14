// Created by manny_lopez on 5/14/24.

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct TextDocument: FileDocument {
  static var readableContentTypes: [UTType] {
    [.plainText]
  }

  var text = ""

  init(text: String) {
    self.text = text
  }

  init(configuration: ReadConfiguration) throws {
    if let data = configuration.file.regularFileContents {
      text = String(decoding: data, as: UTF8.self)
    } else {
      text = "Error"
    }
  }

  func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
    FileWrapper(regularFileWithContents: Data(text.utf8))
  }


}
