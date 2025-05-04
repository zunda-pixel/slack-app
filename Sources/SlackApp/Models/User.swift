import Foundation

struct User: Identifiable {
  var id: UUID = UUID()
  var name: String
}

extension User {
  static let matt = User(name: "Matt Brewer")
  static let geeta = User(name: "Geeta Joshi")
}
