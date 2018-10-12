

import UIKit

protocol ColoredView {
  var controllerColor: UIColor { get set }
}

class MainViewController: UIViewController {
  
  // MARK: - Properties
  var scrollViewController: ScrollViewController!
  
  lazy var chatViewController: UIViewController! = {
    return self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController")
  }()
  
  lazy var discoverViewController: UIViewController! = {
    return self.storyboard?.instantiateViewController(withIdentifier: "DiscoverViewController")
  }()
  
  lazy var lensViewController: UIViewController! = {
    return self.storyboard?.instantiateViewController(withIdentifier: "LensViewController")
  }()
  
  var cameraViewController: CameraViewController!
  
  // MARK: - IBOutlets
  @IBOutlet var navigationView: NavigationView!
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("in prepare for segue method")
    if let controller = segue.destination as? CameraViewController {
      cameraViewController = controller
    } else if let controller = segue.destination as? ScrollViewController {
      scrollViewController = controller
      scrollViewController.delegate = self
    }
  }
}

// MARK: - IBActions
extension MainViewController {
  
  @IBAction func handleChatIconTap(_ sender: UITapGestureRecognizer) {
    scrollViewController.setController(to: chatViewController, animated: true)
  }
  
  @IBAction func handleDiscoverIconTap(_ sender: UITapGestureRecognizer) {
    scrollViewController.setController(to: discoverViewController, animated: true)
  }
  
  @IBAction func handleCameraButton(_ sender: UITapGestureRecognizer) {
    scrollViewController.setController(to: lensViewController, animated: true)
  }
}

// MARK: ScrollViewControllerDelegate
extension MainViewController: ScrollViewControllerDelegate {
  
  var viewControllers: [UIViewController?] {
    return [chatViewController, lensViewController, discoverViewController]
  }
  
  var initialViewController: UIViewController {
    return lensViewController
  }
  
  func scrollViewDidScroll() {
    
    // calculate percentage for animation
    let min: CGFloat = 0
    let max: CGFloat = scrollViewController.pageSize.width
    let x = scrollViewController.scrollView.contentOffset.x
    let result = ((x - min) / (max - min)) - 1
    
    // check which controller is in the foreground.
    // This is for animated controller-specific info
    // (eg. background color)
    var controller: UIViewController?
    if scrollViewController.isControllerVisible(chatViewController) {
      controller = chatViewController
    } else if scrollViewController.isControllerVisible(discoverViewController) {
      controller = discoverViewController
    }
    
    navigationView.animate(to: controller, percent: result)
  }
}

