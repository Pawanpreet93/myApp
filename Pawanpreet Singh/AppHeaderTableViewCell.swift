
import UIKit

class AppHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var appIconImage: UIImageView!
    
    @IBOutlet weak var watchIconImage: UIImageView!
    
    @IBOutlet weak var appNameLabel: UILabel!

    @IBOutlet weak var watchLabel: UILabel!
    
    @IBOutlet weak var developerNameLabel: UILabel!
    
    @IBOutlet weak var appStatus: UIButton!
    
    @IBOutlet weak var ratingCountLabel: UILabel!
    
    @IBOutlet var ratingStars: [UIImageView]!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        appStatus.layer.borderColor = Colors.buttonColor.CGColor
        appStatus.layer.borderWidth = 1
        appStatus.layer.cornerRadius = 5
        
        appIconImage.layer.cornerRadius = 20
        appIconImage.clipsToBounds = true
        appIconImage.layer.borderColor = Colors.darkGrayTintColor.CGColor
        appIconImage.layer.borderWidth = 1
        
        watchIconImage.layer.cornerRadius = 10
        watchIconImage.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
