
import UIKit

class LanguagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    {
        didSet{
            backgroundImage.layer.cornerRadius = 20
            backgroundImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var imageTintView: UIView!{
        didSet{
            imageTintView.backgroundColor = Colors.darkGrayTintColor
            imageTintView.layer.cornerRadius = 20
            imageTintView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var graphView: SingleGraph!
    @IBOutlet weak var percentageLabel: UILabel!

    @IBOutlet weak var languageTitleLabel: UILabel!
}
