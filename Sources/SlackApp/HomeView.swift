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
extension UIImage {
  convenience init(uiColor: UIColor) {
    let createImage = { (rawColor: UIColor) -> UIImage in
      let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
      UIGraphicsBeginImageContext(rect.size)
      let context = UIGraphicsGetCurrentContext()!
      context.setFillColor(rawColor.cgColor)
      context.fill(rect)
      let image = UIGraphicsGetImageFromCurrentImageContext()!
      UIGraphicsEndImageContext()
      return image
    }

    self.init()

    let appearances: [UIUserInterfaceStyle] = [.light, .dark]
    appearances.forEach {
      let traitCollection = UITraitCollection(userInterfaceStyle: $0)
      self.imageAsset?.register(
        createImage(uiColor.resolvedColor(with: traitCollection)),
        with: traitCollection
      )
    }
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
  @State var text: String = ""
  @FocusState var searchBarFocused: Bool?
  @State var selectedTab: SearchTabItem = .recents

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
            List {
              ForEach(0..<30) { i in
                Text("\(tab.rawValue) \(i)")
                  .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
              }
            }
            .introspect(.list, on: .iOS(.v18)) {
              $0.contentInset.top = -35
            }
          } label: {
            Label(tab.rawValue, systemImage: "house")
          }
        }
      }
      .tabViewStyle(.page)
    } else {
      List {
        multiMenuSection
        externalConnectionSection
        chanelsSection
        directMessagesSection
        appsSection
        addTeammatesButton
      }
      .listStyle(.inset)
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

extension Color {
  static let slack = Color(red: 60/255, green: 16/255, blue: 66/255)
}
