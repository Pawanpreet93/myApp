
import UIKit

class ScreenshotCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.borderColor = Colors.darkGrayTintColor.CGColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
    }

}
