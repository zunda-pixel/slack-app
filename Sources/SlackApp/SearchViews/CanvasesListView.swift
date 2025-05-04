import SwiftUI

struct Canvas: Identifiable {
  var id: UUID = UUID()
  var name: String
  var uploadedAt: Date
}

struct CanvasListView: View {
  @State var canvases: [Canvas] = [
    .init(name: "Hello.swift", uploadedAt: .now.addingTimeInterval(-1234500)),
    .init(name: "World.swift", uploadedAt: .now.addingTimeInterval(-6789000)),
  ]
  
  @ViewBuilder
  func itemView(_ canvas: Canvas) -> some View {
    Label {
      VStack(alignment: .leading) {
        Text(canvas.name)
        Text("Last viewed \(canvas.uploadedAt, format: .dateTime.month().day())")
          .foregroundStyle(.secondary)
          .font(.caption)
      }
    } icon: {
      Image(systemName: "text.document")
        .imageScale(.medium)
        .foregroundStyle(.white)
        .padding(6)
        .background(in: .buttonBorder, fillStyle: .init())
        .backgroundStyle(.cyan)
    }
  }
  
  var body: some View {
    List {
      Section("Recent viewed") {
        Button {
          
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
        
        
        ForEach(canvases) { canvas in
          itemView(canvas)
            .listRowSeparator(.hidden)
        }
      }
    }
    .listStyle(.plain)
  }
}

#Preview {
  CanvasListView()
}
