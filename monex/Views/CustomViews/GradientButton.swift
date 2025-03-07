import UIKit

class GradientButton : UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpButton()
    }
    
    private func setUpButton() {
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        layer.cornerRadius = 8
        clipsToBounds = true
        applyGradientColor()
    }
    
    private func applyGradientColor() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor(hexString: "#2FDAFF")?.cgColor ?? UIColor.systemBlue.cgColor,
            UIColor(hexString: "#0E33F3")?.cgColor ?? UIColor.cyan.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = 8
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.sublayers?.first?.frame = bounds
    }
}

extension UIColor {
    convenience init?(hexString hex: String) {
      var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

      if cString.hasPrefix("#") {
        cString.remove(at: cString.startIndex)
      }

      guard cString.count == 6 else {
        return nil
      }

      var rgbValue: UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)

      self.init(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
      )
    }
}
