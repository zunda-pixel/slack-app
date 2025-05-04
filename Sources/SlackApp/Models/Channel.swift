import Foundation

struct Channel: Identifiable {
  var id: UUID = UUID()
  var name: String
  var isPrivate = false
}
