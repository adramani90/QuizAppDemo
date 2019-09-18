

import UIKit


// MARK: - Extension of UIStoryboard
extension UIStoryboard {
    static let main = UIStoryboard(name: "Main", bundle: nil)
}

// MARK: - Extension of UIViewController
extension UIViewController {
    
    /// Show alert with title and message.
    ///
    /// - Parameters:
    ///   - title: Title that need to display with alert popup. Default is nil.
    ///   - message: Message that need to display with alert popup.
    ///   - firstBtnName: First button name of alert popup. Default is OK.
    ///   - firstBtnHandler: First button handler of alert popup. Default is nil.
    ///   - secondBtnName: Set to display second button with alert popup. Default is nil.
    ///   - secondBtnHandler: Second button handler of alert popup. Default is nil.
    func showAlert(title: String? = nil, message: String, firstBtnName: String = "OK", firstBtnHandler: ((UIAlertAction) -> Void)? = nil, secondBtnName: String? = nil, secondBtnHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: firstBtnName, style: .default, handler: firstBtnHandler))
        if secondBtnName != nil {
            alertController.addAction(UIAlertAction(title: secondBtnName, style: .default, handler: secondBtnHandler))
        }
        self.present(alertController, animated: true)
    }
    
    
}

// MARK: - Extension of UITableView
extension UITableView {
    
    /// Register nib with tableview.
    ///
    /// - Parameters:
    ///   - name: Name of xib file.
    ///   - identifier: Cell reuse identifier for this xib. If this argument don't pass then reuse identifier is same as name of xib file.
    func registerNib(withName name: String, identifier: String = "") {
        let cellIdentifier = identifier.isEmpty ? name : identifier
        self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

// MARK: - Extension of UIView
extension UIView {
    /// Make square view to circle by setting corner radius.
    func makeCircleRadius() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
    }
    func addGradiantView(direction: GradientView.Direction = .horizontal){
        for v in self.subviews{
            if v.tag == 11111{
                v.removeFromSuperview()
            }
        }
        let gradientView = GradientView(frame: self.bounds)
        gradientView.tag = 11111
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        gradientView.colors = [UIColor.AppColor.colorThemeDark, UIColor.AppColor.colorLightTheme]
        gradientView.direction = direction
        gradientView.isUserInteractionEnabled = false
        self.addSubview(gradientView)
        self.sendSubviewToBack(gradientView)
    }
    
    
    func makeBorder(with border:CGFloat, borderColor:UIColor, cornerRedius:CGFloat){
        self.clipsToBounds = true
        self.layer.borderWidth = border
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRedius
        
    }
    
    func makeCornerRedius(with cornerRedius:CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRedius
    }
}



// MARK: - Extension of UICollectionView
extension UICollectionView {
    
    /// Register nib with collectionView.
    ///
    /// - Parameters:
    ///   - name: Name of xib file.
    ///   - identifier: Cell reuse identifier for this xib. If this argument don't pass then reuse identifier is same as name of xib file.
    func registerNib(withName name: String, identifier: String = "") {
        let cellIdentifier = identifier.isEmpty ? name : identifier
        self.register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    
    /// Get indexPath for view that is inside in table cell.
    ///
    /// - Parameter view: View from which need to get indexPath.
    /// - Returns: IndexPath of tableview cell. May nil if indexPath not found for this view.
    func indexPathFor(view: UIView) -> IndexPath? {
        if let point = view.superview?.convert(view.center, to: self) {
            return self.indexPathForItem(at: point)
        }
        return nil
    }
    
}




// MARK: - Extension of UIColor
extension UIColor {
    
    /// Struct of Custom color that is used in application.
    struct AppColor {
        static let colorThemeDark = #colorLiteral(red: 0.7960784314, green: 0.262745098, blue: 0.2078431373, alpha: 1)
        static let colorLightTheme = #colorLiteral(red: 0.9960784314, green: 0.3176470588, blue: 0.3882352941, alpha: 1)
        static let colorRed = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        static let colorGreen = #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1)
        static let colorBlack = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        static let colorBlue = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        static let colorThemeLight = #colorLiteral(red: 0.7960784314, green: 0.262745098, blue: 0.2078431373, alpha: 0.4)

    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

