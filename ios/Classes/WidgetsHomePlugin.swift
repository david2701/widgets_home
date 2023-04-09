import Flutter
import UIKit


public class WidgetsHomePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "widgets_home", binaryMessenger: registrar.messenger())
        let instance = WidgetsHomePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "createCustomWidget" {
            guard let args = call.arguments as? [String: Any],
                  let text = args["text"] as? String,
                  let imageUrl = args["imageUrl"] as? String,
                  let backgroundColor = args["backgroundColor"] as? String,
                  let width = args["width"] as? CGFloat,
                  let height = args["height"] as? CGFloat else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid or missing arguments", details: nil))
                return
            }
            createCustomWidget(text: text, imageUrl: imageUrl, backgroundColor: backgroundColor, width: width, height: height)
            result(nil)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }


    private func createCustomWidget(text: String, imageUrl: String, backgroundColor: String, width: CGFloat, height: CGFloat) {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        customView.backgroundColor = UIColor(hexString: backgroundColor)

        let label = UILabel()
        label.text = text
        label.sizeToFit()
        label.center = customView.center
        customView.addSubview(label)

        if let url = URL(string: imageUrl) {
            let imageView = UIImageView()
            imageView.load(url: url)
            imageView.frame = customView.bounds
            imageView.contentMode = .scaleAspectFill
            customView.insertSubview(imageView, at: 0)
        }

        // Asegurándose de que estás en el hilo principal
        DispatchQueue.main.async {
            // Obtiene la ventana principal de la aplicación
            if let keyWindow = UIApplication.shared.keyWindow {
                // Centra el widget personalizado en la ventana principal
                customView.center = keyWindow.center

                // Agrega el widget personalizado a la ventana principal
                keyWindow.addSubview(customView)
            }
        }
    }
}

// Extensión para cargar imágenes desde URL
extension UIImageView {
  func load(url: URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      }
    }
  }
}

// Extensión para UIColor desde un código hexadecimal
extension UIColor {
  convenience init(hexString: String) {
    let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let scanner = Scanner(string: hexString)

    if (hexString.hasPrefix("#")) {
      scanner.currentIndex = scanner.string.index(after: scanner.string.startIndex)
    }

    var color: UInt64 = 0
    scanner.scanHexInt64(&color)

    let mask = 0x000000FF
    let r = Int(color >> 16) & mask
    let g = Int(color >> 8) & mask
    let b = Int(color) & mask

    let red = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue = CGFloat(b) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: 1)
  }
}
