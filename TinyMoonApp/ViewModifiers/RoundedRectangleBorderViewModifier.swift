// Created by manny_lopez on 5/15/24.
// Copyright © 2024 Airbnb Inc. All rights reserved.

import SwiftUI

struct RoundedRectangleBorder: ViewModifier {
  private let cornerRadius: CGFloat = 10
  func body(content: Content) -> some View {
    content
      .background(
        RoundedRectangle(cornerRadius: cornerRadius)
          .fill(Color.gray.opacity(0.1))
      )
      .overlay(
        RoundedRectangle(cornerRadius: cornerRadius)
          .stroke(Color.gray, lineWidth: 2)
      )
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
  }
}
