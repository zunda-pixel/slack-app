import SwiftUI

enum TabItem: String, CaseIterable, Sendable, Hashable {
  case home = "Home"
  case dm = "DM"
  case activity = "Activity"
  case canvas = "Canvas"
  case list = "List"
  case connectToExternal = "Connect to External"
  
  var systemImage: String {
    switch self {
    case .home: "house"
    case .dm: "bubble.left.and.text.bubble.right"
    case .activity: "bell"
    case .canvas: "square.and.arrow.up"
    case .list: "list.bullet"
    case .connectToExternal: "command.circle"
    }
  }
}

struct ContentView: View {
  @State var selectedTab: TabItem = .home
  
  @ViewBuilder
  func tabView(tab: TabItem) -> some View {
    switch tab {
    case .home:
      HomeView()
    case .dm:
      DMView()
    case .activity:
      ActivityView()
    case .canvas:
      CanvasView()
    case .list:
      ListView()
    case .connectToExternal:
      ConnectToExternalView()
    }
  }
  
  var body: some View {
    TabView(selection: $selectedTab) {
      ForEach(TabItem.allCases, id: \.self) { tabItem in
        tabView(tab: tabItem)
          .tag(tabItem)
          .tabItem {
            Label(tabItem.rawValue, systemImage: tabItem.systemImage)
              // https://stackoverflow.com/questions/70057749/why-swiftui-tabitem-systemimage-is-filled
              .environment(\.symbolVariants, tabItem == selectedTab ? .fill : .none)
          }
      }
    }
  }
}

#Preview {
  ContentView()
    .tint(Color.primary)
}

#if canImport(AppKit)
extension NSColor {
  static let secondarySystemGroupedBackground: NSColor = .systemGray
  static let secondarySystemBackground: NSColor  = .systemGray
}
#endif
