// Created by manny_lopez on 5/14/24.

import AppKit
import os
import SwiftUI

struct OnAppearLogEventViewModifier: ViewModifier {
  let event: String

  func body(content: Content) -> some View {
    content.onAppear {
      Logger.log(event: event)
    }
  }
}
