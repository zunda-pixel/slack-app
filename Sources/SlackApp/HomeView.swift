import SwiftUI
import SwiftUIIntrospect

enum Menu: CaseIterable {
  case threads
  case huddles
  case todos
  case draftAndSent
  
  var item: Item {
    switch self {
    case .threads: Item(systemImage: "text.bubble", title: "Threads", description: "1 new")
    case .huddles: Item(systemImage: "headphones", title: "Huddles", description: "1 saved")
    case .todos: Item(systemImage: "tag", title: "Later", description: "1 saved")
    case .draftAndSent: Item(systemImage: "paperplane", title: "Draft & Sent", description: "3 scheduled0")
    }
  }
  
  struct Item {
    var systemImage: String
    var title: String
    var description: String
  }
}

struct HomeView: View {
  @State var text: String = ""

  var multiMenuSection: some View {
    Section {
      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(Menu.allCases, id: \.self) { menu in
            VStack(alignment: .leading) {
              Image(systemName: menu.item.systemImage)
              Text(menu.item.title)
              Text(menu.item.description)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
              RoundedRectangle(
                cornerRadius: 13,
                style: .continuous
              )
              .fill(Color.gray.opacity(0.1))
            }
          }
          Image(systemName: "gearshape")
            .padding(7)
            .background {
              Circle()
                .fill(Color.gray.opacity(0.1))
            }
        }
      }
      .scrollClipDisabled()
      .scrollIndicators(.hidden)
    }
  }
  
  @ViewBuilder
  var externalConnectionSection: some View {
    Section("External Connection") {
      
    }
  }
  
  @ViewBuilder
  var chanelsSection: some View {
    Section("Channels") {
    }
  }
  
  @ViewBuilder
  var directMessagesSection: some View {
    Section("Direct Messages") {
    }
  }
  
  @ViewBuilder
  var appsSection: some View {
    Section("Apps") {
    }
  }
  
  var addTeammatesButton: some View {
    Button {
      
    } label: {
      Label("Add teammates", systemImage: "plus")
    }
  }
  
  @ToolbarContentBuilder
  var toolbar: some ToolbarContent {
    #if os(macOS)
    let placement1: ToolbarItemPlacement = .navigation
    #else
    let placement1: ToolbarItemPlacement = .topBarLeading
    #endif
    
    ToolbarItem(placement: placement1) {
      HStack(spacing: 4) {
        Button {
          
        } label: {
          Image(systemName: "ladybug")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundStyle(Color.slack)
            .padding(6)
            .background {
              RoundedRectangle(cornerRadius: 9)
                .fill(Color.yellow)
            }
        }
        Text("Acmec Inc")
          .bold()
          .foregroundStyle(.white)
      }
    }
    
    #if os(macOS)
    let placement2: ToolbarItemPlacement = .navigation
    #else
    let placement2: ToolbarItemPlacement = .topBarTrailing
    #endif
    ToolbarItem(placement: placement2) {
      Button {
        
      } label: {
        Image(systemName: "face.smiling.inverse")
          .resizable()
          .frame(width: 22, height: 22)
          .foregroundStyle(.white)
          .padding(5)
          .background {
            RoundedRectangle(cornerRadius: 9)
              .fill(Color.pink)
          }
          .overlay(alignment: .bottomTrailing) {
            Circle()
              .fill(Color.slack)
              .frame(width: 14, height: 14)
              .offset(x: 5, y: 5)
              .overlay {
                Circle()
                  .foregroundStyle(.white)
                  .frame(width: 7, height: 7)
                  .offset(x: 4, y: 4)
              }
          }
      }
    }
  }
  
  var body: some View {
    NavigationStack {
      List {
        multiMenuSection
        externalConnectionSection
        chanelsSection
        directMessagesSection
        appsSection
        addTeammatesButton
      }
      .listStyle(.inset)
      #if !os(macOS)
      .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(Color.slack, for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      #endif
      .searchable(text: $text, prompt: "Jump to or search...")
      .toolbar {
        toolbar
      }
      .overlay(alignment: .bottomTrailing) {
        Image(systemName: "square.and.pencil")
          .foregroundStyle(.white)
          .padding(15)
          .background {
            Circle()
              .fill(Color.slack)
          }
          .padding(10)
      }
    }
    #if os(macOS)
    #else
    .introspect(.searchField, on: .iOS(.v18)) {
      $0.searchTextField.attributedPlaceholder = NSAttributedString(
        string: "Jump to or search...",
        attributes: [.foregroundColor: UIColor.white]
      )
      // set magnifyingglass color
      $0.searchTextField.leftView?.tintColor = .white
      // set clearbutton color
      let clearButton = $0.searchTextField.value(forKey: "clearButton") as! UIButton
      clearButton.setImage(
        clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate),
        for: .normal
      )
      clearButton.tintColor = UIColor.white
      // set cancelbutton color
      $0.tintColor = .white
      // set text color
      $0.searchTextField.textColor = .white
    }
    #endif
  }
}

#Preview {
  HomeView()
}

extension Color {
  static let slack = Color(red: 60/255, green: 16/255, blue: 66/255)
}
