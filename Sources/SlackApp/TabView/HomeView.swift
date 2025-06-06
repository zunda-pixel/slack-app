import SwiftUI
import SwiftUIIntrospect

enum MenuItem: CaseIterable {
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

enum SearchTabItem: String, CaseIterable {
  case recents = "Recents"
  case files = "Files"
  case canvases = "Canvases"
  case channels = "Channels"
  case people = "People"
  case workflows = "Workflows"
}

struct HomeView: View {
  @State var isPresentedNewContents: Bool = false
  @State var text: String = ""
  @FocusState var searchBarFocused: Bool?
  @State var selectedTab: SearchTabItem = .recents

  var multiMenuSection: some View {
    Section {
      ScrollView(.horizontal) {
        HStack {
          ForEach(MenuItem.allCases, id: \.self) { menu in
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
    DisclosureGroup {
      
    } label: {
      Text("External Connection")
        .bold()
        .padding(.vertical, 8)
    }
  }
  
  @ViewBuilder
  var chanelsSection: some View {
    DisclosureGroup {
    } label: {
      Text("Channels")
        .bold()
        .padding(.vertical, 8)
    }
  }
  
  @ViewBuilder
  var directMessagesSection: some View {
    DisclosureGroup {
    } label: {
      Text("Direct Messages")
        .bold()
        .padding(.vertical, 8)
    }
  }
  
  @ViewBuilder
  var appsSection: some View {
    DisclosureGroup {
    } label: {
      Text("Apps")
        .bold()
        .padding(.vertical, 8)
    }
  }
  
  var addTeammatesButton: some View {
    Button {
      
    } label: {
      Label("Add teammates", systemImage: "plus")
    }
    .foregroundStyle(.secondary)
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
                  .foregroundStyle(.green)
                  .frame(width: 7, height: 7)
                  .offset(x: 4, y: 4)
              }
          }
      }
    }
  }
  
  @ViewBuilder
  var content: some View {
    if searchBarFocused == true {
      TabView(selection: $selectedTab) {
        ForEach(SearchTabItem.allCases, id: \.self) { tab in
          Tab(value: tab) {
            switch tab {
            case .recents: RecentListView()
            case .files: FileListView()
            case .canvases: CanvasListView()
            case .channels: ChannelListView()
            case .people: PersonListView()
            case .workflows: WorkflowListView()
            }
          } label: {
            Label(tab.rawValue, systemImage: "house")
          }
        }
      }
      .tabViewStyle(.page(indexDisplayMode: .never))
    } else {
      List {
        multiMenuSection
          .alignmentGuide(.listRowSeparatorLeading) { _ in  -20 }
          .listRowBackground(
            Rectangle()
              .foregroundStyle(.thinMaterial)
          )
        externalConnectionSection
          .alignmentGuide(.listRowSeparatorLeading) { _ in  -20 }
          .listRowBackground(
            Rectangle()
              .foregroundStyle(.thinMaterial)
          )
        chanelsSection
          .alignmentGuide(.listRowSeparatorLeading) { _ in  -20 }
          .listRowBackground(
            Rectangle()
              .foregroundStyle(.thinMaterial)
          )
        directMessagesSection
          .alignmentGuide(.listRowSeparatorLeading) { _ in  -20 }
          .listRowBackground(
            Rectangle()
              .foregroundStyle(.thinMaterial)
          )
        appsSection
          .alignmentGuide(.listRowSeparatorLeading) { _ in  -20 }
          .listRowBackground(
            Rectangle()
              .foregroundStyle(.thinMaterial)
          )
        addTeammatesButton
          .alignmentGuide(.listRowSeparatorLeading) { _ in  -20 }
          .listRowBackground(
            Rectangle()
              .foregroundStyle(.thinMaterial)
          )
      }
      .listStyle(.inset)
      .scrollContentBackground(.hidden)
      .background(
        Rectangle()
        .foregroundStyle(.thinMaterial)
      )
    }
  }
  
  var body: some View {
    NavigationStack {
      content
      .safeAreaInset(edge: .top, spacing: 0) {
        if searchBarFocused == true {
          ScrollView(.horizontal) {
            HStack {
              Picker("Select Tab", selection: $selectedTab) {
                ForEach(SearchTabItem.allCases, id: \.self) { tab in
                  Text(tab.rawValue)
                }
              }
              .pickerStyle(.segmented)
              .padding(.horizontal, 10)
              .padding(.vertical, 5)
            }
          }
          .background(Color.slack)
        }
      }
      // MARK: contentがGroupのためPicker直下につけても効果がない
      .introspect(.picker(style: .segmented), on: .iOS(.v18)) {
        $0.setDividerImage(
          UIImage(uiColor: .clear),
          forLeftSegmentState: .normal,
          rightSegmentState: .normal,
          barMetrics: .default
        )
        $0.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        $0.setTitleTextAttributes([.foregroundColor: UIColor(.slack)], for: .selected)
        $0.selectedSegmentTintColor = UIColor(red: 226/255, green: 207/255, blue: 217/255, alpha: 1)
      }
      #if !os(macOS)
      .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(Color.slack, for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      #endif
      .searchable(text: $text, prompt: "Jump to or search...")
      .searchFocused($searchBarFocused, equals: true)
      .toolbar {
        toolbar
      }
      .overlay(alignment: .bottomTrailing) {
        Button {
          isPresentedNewContents.toggle()
        } label: {
          Image(systemName: "plus")
            .foregroundStyle(.white)
            .padding(15)
            .background {
              Circle()
                .fill(Color.slack)
            }
            .padding(10)
        }
      }
      .sheet(isPresented: $isPresentedNewContents) {
        List {
          Button {
            
          } label: {
            Label {
              VStack(alignment: .leading) {
                Text("Huddle")
                  .bold()
                Text("Start an audio or video chat")
                  .font(.caption)
              }
            } icon: {
              RoundedRectangle(cornerRadius: 9)
                .fill(Color.slack.opacity(0.5))
                .frame(width: 40, height: 40)
                .overlay {
                  Image(systemName: "headphones")
                    .imageScale(.medium)
                    .foregroundStyle(Color.thinPink)
                }
            }
          }
          .tint(.white)
          .listRowSeparator(.hidden)

          Button {
            
          } label: {
            Label {
              VStack(alignment: .leading) {
                Text("Channel")
                  .bold()
                Text("Organize teams and work")
                  .font(.caption)
              }
            } icon: {
              RoundedRectangle(cornerRadius: 9)
                .fill(Color.slack.opacity(0.5))
                .frame(width: 40, height: 40)
                .overlay {
                  Text("#")
                    .foregroundStyle(Color.thinPink)
                }
            }
          }
          .tint(.white)
          .listRowSeparator(.hidden)
          
          Button {
            
          } label: {
            Text("\(Image(systemName: "square.and.pencil"))  Message")
              .frame(maxWidth: .infinity)
              .padding(.vertical, 8)
              .foregroundStyle(Color.thinPink)
          }
          .bold()
          .foregroundStyle(.white)
          .background(Color.slack, in: .rect(cornerRadius: 14))
          .listRowSeparator(.hidden)
        }
        .presentationDetents([.height(230)])
      }
    }
    #if os(iOS)
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
      $0.searchTextField.backgroundColor = UIColor(red: 184/255, green: 127/255, blue: 180/255, alpha: 0.5)
    }
    #endif
  }
}

#Preview {
  HomeView()
}
