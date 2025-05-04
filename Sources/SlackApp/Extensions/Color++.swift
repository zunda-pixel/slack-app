import SwiftUI

extension Color {
  static let slack = Color(red: 60/255, green: 16/255, blue: 66/255)
  static let button = Color(red: 64/255, green: 104/255, blue: 164/255)
}

#Preview {
  let colors: [Color] = [
    .slack,
    .button
  ]
  
  List {
    ForEach(colors, id: \.self) { color in
      color
    }
  }
}
