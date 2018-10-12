

import UIKit

class LensViewController: UIViewController {
  @IBOutlet weak var faceImage: UIImageView!
  @IBOutlet weak var lensCollectionView: UICollectionView!
  
  private lazy var lensFiltersImages: [UIImage] = {
    var images: [UIImage] = []
    for i in 0...19 {
      guard let image = UIImage(named: "face\(i)") else { break }
      images.append(image)
    }
    return images
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    lensCollectionView.delegate = self
    lensCollectionView.dataSource = self
    lensCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    lensCollectionView.register(LensCircleCell.self, forCellWithReuseIdentifier: LensCircleCell.identifier)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    let middleIndexPath = IndexPath(item: lensFiltersImages.count/2, section: 0)
    selectCell(for: middleIndexPath, animated: false)
  }
  
  private func selectCell(for indexPath: IndexPath, animated: Bool) {
    lensCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
    faceImage.image = lensFiltersImages[indexPath.row]
  }
}

// MARK: UICollectionViewDelegate
extension LensViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return lensFiltersImages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectCell(for: indexPath, animated: true)
  }
}

// MARK: UICollectionViewDataSource
extension LensViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LensCircleCell.identifier, for: indexPath) as? LensCircleCell else { fatalError() }
    
    cell.image = lensFiltersImages[indexPath.row]
    return cell
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension LensViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let side = lensCollectionView.frame.height * 0.9
    return CGSize(width: side, height: side)
  }
}

// MARK: UIScrollViewDelegate
extension LensViewController: UIScrollViewDelegate {
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let bounds = lensCollectionView.bounds
    
    let xPosition = lensCollectionView.contentOffset.x + bounds.size.width/2.0
    let yPosition = bounds.size.height/2.0
    let xyPoint = CGPoint(x: xPosition, y: yPosition)
    
    guard let indexPath = lensCollectionView.indexPathForItem(at: xyPoint) else { return }
    
    selectCell(for: indexPath, animated: true)
  }
  
  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    scrollViewDidEndDecelerating(scrollView)
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if !decelerate {
      scrollViewDidEndDecelerating(scrollView)
    }
  }
}
