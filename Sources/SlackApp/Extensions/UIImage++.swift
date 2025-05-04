import SwiftUI

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
