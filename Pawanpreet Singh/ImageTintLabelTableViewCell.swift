
import UIKit

class ImageTintLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundParallaxView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var overlayTintView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
