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
        Tab(value: tabItem) {
          tabView(tab: tabItem)
        } label: {
          Label(tabItem.rawValue, systemImage: tabItem.systemImage)
        }
      }
    }
    #if !os(macOS)
    .introspect(.tabView(style: .page), on: .iOS(.v18, .v26)) {
      $0.backgroundColor = .secondarySystemBackground
    }
    #endif
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
