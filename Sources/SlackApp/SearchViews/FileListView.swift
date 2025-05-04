import SwiftUI

struct File: Identifiable {
  var id: UUID = UUID()
  var name: String
  var uploadedBy: User
  var uploadedAt: Date
}

struct FileListView: View {
  @State var files: [File] = [
    .init(name: "Hello.swift", uploadedBy: .geeta, uploadedAt: .now.addingTimeInterval(-1234500)),
    .init(name: "World.swift", uploadedBy: .matt, uploadedAt: .now.addingTimeInterval(-6789000)),
  ]
  
  @ViewBuilder
  func itemView(_ file: File) -> some View {
    Label {
      VStack(alignment: .leading) {
        Text(file.name)
        Text("\(file.uploadedBy.name) · \(file.uploadedAt, format: .dateTime.month().day())")
          .foregroundStyle(.secondary)
          .font(.caption)
      }
    } icon: {
      Image(systemName: "text.document")
    }
  }
  
  var body: some View {
    List {
      Section("Recent viewed") {
        ForEach(files) { file in
          itemView(file)
            .listRowSeparator(.hidden)
        }
      }
    }
    .listStyle(.plain)
  }
}

#Preview {
  FileListView()
}
