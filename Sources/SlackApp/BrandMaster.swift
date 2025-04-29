import SwiftUI

struct BrandMaster: View {
  var body: some View {
    List {
      HStack {
        TextField("新しいブランド名", text: .constant(""))
        Button("追加") {
          
        }
      }
      ForEach(0..<20) { i in
        Text("ブランド\(i)")
      }
    }
  }
}

#Preview {
  BrandMaster()
    .frame(maxWidth: 400, maxHeight: 400)
}
