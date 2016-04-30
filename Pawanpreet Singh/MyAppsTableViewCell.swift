
import UIKit

class MyAppsTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var appStatus: UIButton!
    @IBOutlet weak var ratingCountLabel: UILabel!
    
    @IBOutlet var ratingStars: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        appStatus.layer.borderColor = Colors.buttonColor.CGColor
        appStatus.layer.borderWidth = 1
        appStatus.layer.cornerRadius = 5
        
        iconImageView.layer.cornerRadius = 15
        iconImageView.clipsToBounds = true
        iconImageView.layer.borderColor = Colors.darkGrayTintColor.CGColor
        iconImageView.layer.borderWidth = 1
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
   

}
