

import UIKit

class NavigationView: UIView {
  
  // MARK: - Properties
  lazy var cameraButtonWidthConstraintConstant: CGFloat = {
    return self.cameraButtonWidthConstraint.constant
  }()
  lazy var cameraButtonBottomConstraintConstant: CGFloat = {
    return self.cameraButtonBottomConstraint.constant
  }()
  lazy var chatIconWidthConstraintConstant: CGFloat = {
    return self.chatIconWidthConstraint.constant
  }()
  lazy var chatIconBottomConstraintConstant: CGFloat = {
    return self.chatIconBottomConstraint.constant
  }()
  lazy var chatIconHorizontalConstraintConstant: CGFloat = {
    return self.chatIconHorizontalConstraint.constant
  }()
  lazy var discoverIconHorizontalConstraintConstant: CGFloat = {
    return self.discoverIconHorizontalConstraint.constant
  }()
  lazy var indicatorTransform: CGAffineTransform = {
    return self.cameraButtonView.transform
  }()
  
  @IBOutlet var cameraButtonView: UIView!
  @IBOutlet var cameraButtonWhiteView: UIImageView!
  @IBOutlet var cameraButtonGrayView: UIImageView!
  @IBOutlet var cameraButtonWidthConstraint: NSLayoutConstraint!
  @IBOutlet var cameraButtonBottomConstraint: NSLayoutConstraint!
  
  @IBOutlet var chatIconView: UIView!
  @IBOutlet var chatIconWhiteView: UIImageView!
  @IBOutlet var chatIconGrayView: UIImageView!
  @IBOutlet var chatIconWidthConstraint: NSLayoutConstraint!
  @IBOutlet var chatIconBottomConstraint: NSLayoutConstraint!
  @IBOutlet var chatIconHorizontalConstraint: NSLayoutConstraint!
  
  @IBOutlet var discoverIconView: UIView!
  @IBOutlet var discoverIconWhiteView: UIImageView!
  @IBOutlet var discoverIconGrayView: UIImageView!
  @IBOutlet var discoverIconHorizontalConstraint: NSLayoutConstraint!
  
  @IBOutlet var indicator: UIView!
  
  @IBOutlet var colorView: UIView!
  
  // MARK: - Internal
  func shadow(layer: CALayer, color: UIColor) {
    layer.shadowColor = color.cgColor
    layer.masksToBounds = false
    layer.shadowOffset = .zero
    layer.shadowOpacity = 1.0
    layer.shadowRadius = 0.5
  }
  
  func setup() {
    shadow(layer: cameraButtonWhiteView.layer, color: .black)
    shadow(layer: chatIconWhiteView.layer, color: .darkGray)
    shadow(layer: discoverIconWhiteView.layer, color: .darkGray)
  }
  
  // MARK: - View Life Cycle
  override func layoutSubviews() {
    super.layoutSubviews()
    indicator.layer.cornerRadius = indicator.bounds.height / 2
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setup()
  }
  
  // let touches through except for buttons.
  // Buttons have tap gestures on them
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let view = super.hitTest(point, with: event)
    return view == self ? nil : view
  }
  
  func animate(to controller: UIViewController?, percent: CGFloat) {
    let offset = abs(percent)
    
    // fade white to gray
    cameraButtonWhiteView.alpha = 1 - offset
    cameraButtonGrayView.alpha = offset
    
    animateIconColor(offset: offset)
    animateIconPosition(offset: offset)
    animateIconScale(offset: offset)
    animateIconCenter(offset: offset)
    
    animateBottomBar(percent: percent)
    
    // Background color view
    if let controller = controller as? ColoredView {
      colorView.backgroundColor = controller.controllerColor
    }
    
    // animation starts at 0.2 of the way across
    // and is fully faded in at 0.8
    var colorOffset = (offset - 0.2) / (0.8 - 0.2)
    colorOffset = min(max(colorOffset, 0), 1)
    colorView.alpha = colorOffset
    
    layoutIfNeeded()
  }
}

