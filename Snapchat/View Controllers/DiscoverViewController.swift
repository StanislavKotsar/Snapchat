

import UIKit

class DiscoverViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet var backgroundView: UIView!
  
  // MARK: - Properties
  var controllerColor: UIColor = UIColor(red: 0.59, green: 0.23, blue: 0.96, alpha: 1.0)
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    backgroundView.layer.cornerRadius = 20
    backgroundView.layer.masksToBounds = true
  }
}

// MARK: - ColoredView
extension DiscoverViewController: ColoredView {}

