import SwiftUI

struct ChannelListView: View {
  @State var channels: [Channel] = [
    .init(name: "All"),
    .init(name: "Social"),
  ]
  
  @ViewBuilder
  func itemView(_ channel: Channel) -> some View {
    Label {
      Text(channel.name)
        .bold()
    } icon: {
      RoundedRectangle(cornerRadius: 8)
        .aspectRatio(1, contentMode: .fit)
        .foregroundStyle(.regularMaterial)
        .overlay {
          Text("#")
            .bold()
        }
    }
    .foregroundStyle(.primary)
  }
  
  var body: some View {
    List {
      Section("15 channles") {
        Button {
          channels.append(.init(name: "New Channel"))
        } label: {
          Label {
            Text("Create a canvas")
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
        
        ForEach(channels) { channel in
          itemView(channel)
            .listRowSeparator(.hidden)
        }
      }
    }
    .listStyle(.plain)
  }
}

#Preview {
  ChannelListView()
}
