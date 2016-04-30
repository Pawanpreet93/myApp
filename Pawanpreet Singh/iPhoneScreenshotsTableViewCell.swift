
import UIKit

class iPhoneScreenshotsTableViewCell: UITableViewCell {

    @IBOutlet weak var iphoneScreensCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension iPhoneScreenshotsTableViewCell {
    
    func setCollectionViewDataSourceDelegate<D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: D, forRow row: Int) {
        
        iphoneScreensCollectionView.delegate = dataSourceDelegate
        iphoneScreensCollectionView.dataSource = dataSourceDelegate
        iphoneScreensCollectionView.tag = row
        iphoneScreensCollectionView.setContentOffset(iphoneScreensCollectionView.contentOffset, animated:false)
        iphoneScreensCollectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set {
            iphoneScreensCollectionView.contentOffset.x = newValue
        }
        
        get {
            return iphoneScreensCollectionView.contentOffset.x
        }
    }
}

