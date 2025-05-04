import SwiftUI

struct PersonListView: View {
  @State var users: [User] = [
    .geeta,
    .matt,
  ]
  
  @ViewBuilder
  func itemView(_ user: User) -> some View {
    Label {
      Text(user.name)
        .bold()
    } icon: {
      RoundedRectangle(cornerRadius: 8)
        .aspectRatio(1, contentMode: .fit)
        .foregroundStyle(.regularMaterial)
        .overlay {
          Image(systemName: "person")
        }
    }
    .foregroundStyle(.primary)
  }
  
  var body: some View {
    List {
      Section("15 members") {
        Button {
          users.append(.init(name: "New Member"))
        } label: {
          Label {
            Text("Invite a teammate")
              .foregroundStyle(.black)
          } icon: {
            RoundedRectangle(cornerRadius: 8)
              .aspectRatio(1, contentMode: .fit)
              .overlay {
                Image(systemName: "plus")
                  .foregroundStyle(.white)
                  .imageScale(.medium)
              }
          }
        }
        .foregroundStyle(Color.button)
        .listRowSeparator(.hidden)
        
        ForEach(users) { user in
          itemView(user)
            .listRowSeparator(.hidden)
        }
      }
    }
    .listStyle(.plain)
  }
}

#Preview {
  PersonListView()
}
