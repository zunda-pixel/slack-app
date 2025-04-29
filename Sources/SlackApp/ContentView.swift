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

struct BeatyView: View {
  var text = "プレゼンテーション"
  
  var body: some View {
    VStack {
      Rectangle()
        .fill(Color(.secondarySystemGroupedBackground))
        .frame(width: 300, height: 100)
        .overlay {
          Text(text)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .doubleBorder()
        }
        .environment(\.colorScheme, .light)
      Rectangle()
        .fill(Color(.secondarySystemGroupedBackground))
        .frame(width: 300, height: 100)
        .overlay {
          Text(text)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .doubleBorder()
        }
        .environment(\.colorScheme, .dark)
    }
  }
}

#if canImport(AppKit)
extension NSColor {
  static let secondarySystemGroupedBackground: NSColor = .systemGray
  static let secondarySystemBackground: NSColor  = .systemGray
}
#endif

extension View {
  func doubleBorder() -> some View {
    modifier(DoubleBorderModifier())
  }
}

struct DoubleBorderModifier: ViewModifier {
  @Environment(\.colorScheme) var colorScheme
  
  var outlineColor: Color {
    switch colorScheme {
    case .dark: Color.black
    case .light: Color.secondary
    @unknown default:
      fatalError()
    }
  }
  
  var inlineColor: Color {
    switch colorScheme {
    case .dark: Color.secondary
    case .light: Color.white
    @unknown default:
      fatalError()
    }
  }

  func body(content: Content) -> some View {
    content
      .background {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color(.secondarySystemBackground).opacity(0.9))
          .shadow(color: Color(.secondarySystemBackground), radius: 4)
          .overlay {
            RoundedRectangle(cornerRadius: 10)
              .stroke(outlineColor, lineWidth: 0.3)
              .overlay {
                RoundedRectangle(cornerRadius: 9)
                  .stroke(inlineColor, lineWidth: 0.3)
                  .padding(1)
              }
          }
      }
  }
}

#Preview {
  BeatyView()
}
