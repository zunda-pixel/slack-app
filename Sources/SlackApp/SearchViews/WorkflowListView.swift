import SwiftUI

struct WorkflowListView: View {
  @State var workflows: [Workflow] = [

  ]
  
  @ViewBuilder
  func itemView(_ workflow: Workflow) -> some View {
    Label {
      Text(workflow.name)
        .bold()
    } icon: {
      RoundedRectangle(cornerRadius: 8)
        .aspectRatio(1, contentMode: .fit)
        .foregroundStyle(.regularMaterial)
        .overlay {
          Image(systemName: "flowchart")
        }
    }
    .foregroundStyle(.primary)
  }
  
  var body: some View {
    List {
      Section("15 workflows") {
        Button {
          workflows.append(.init(name: "New Workflow"))
        } label: {
          Label {
            Text("Create a workflow")
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
        
        ForEach(workflows) { workflow in
          itemView(workflow)
            .listRowSeparator(.hidden)
        }
      }
    }
    .listStyle(.plain)
  }
}

#Preview {
  WorkflowListView()
}
