import SwiftUI

struct RecentListView: View {
  struct Item: Identifiable {
    var id: UUID = UUID()
    var item: Item
    
    init(_ item: Item) {
      self.item = item
    }
    
    enum Item {
      case word(String)
      case channel(Channel)
      case user(User)
    }
  }
  
  @State var items: [Item] = [
    .init(.word("DB")),
    .init(.channel(.init(name: "Project1", isPrivate: false))),
    .init(.channel(.init(name: "Project2", isPrivate: true))),
    .init(.user(.init(name: "Matt Brewer")))
  ]
  
  @ViewBuilder
  func itemView(_ item: Item.Item) -> some View {
    Label {
      switch item {
      case .word(let word):
        Text(word)
      case .channel(let channel):
        Text(channel.name)
      case .user(let user):
        Text(user.name)
      }
    } icon: {
      switch item {
      case .word(_):
        Image(systemName: "magnifyingglass")
      case .channel(let channel):
        if channel.isPrivate {
          Image(systemName: "lock")
        } else {
          Text("#")
        }
      case .user(_):
        Image(systemName: "person")
      }
    }
    .foregroundStyle(.primary)
  }
  
  var body: some View {
    List {
      ForEach(items) { item in
        itemView(item.item)
          .listRowSeparator(.hidden)
      }
    }
    .listStyle(.plain)
  }
}
#Preview {
  RecentListView()
}
