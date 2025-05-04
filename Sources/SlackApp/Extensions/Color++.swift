import SwiftUI

extension Color {
  static let slack = Color(red: 60/255, green: 16/255, blue: 66/255)
  static let button = Color(red: 64/255, green: 104/255, blue: 164/255)
  static let thinPink = Color(uiColor: .thinPink)
}

extension UIColor {
  static let thinPink = UIColor(red: 184/255, green: 127/255, blue: 180/255, alpha: 1)
}

#Preview {
  let colors: [Color] = [
    .slack,
    .thinPink,
    .button,
  ]
  
  List {
    ForEach(colors, id: \.self) { color in
      color
    }
  }
}
