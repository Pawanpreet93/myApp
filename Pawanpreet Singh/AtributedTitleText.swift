
import Foundation
import UIKit

extension String {
    var length: Int {
        return characters.count
    }
}

class AtributedTitleText{
    static func MakeAtributedTitleString(title: String, size: CGFloat) -> NSAttributedString{
        
         let splitTitleArray = title.characters.split{$0 == " "}.map(String.init)
        
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: splitTitleArray[1])
        
        let boldFontDescriptor = UIFont(name: "Avenir Next",size: size)?.fontDescriptor().fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitBold)
        
        let boldAttribute = [ NSFontAttributeName: UIFont(descriptor: boldFontDescriptor!, size: size)]
        attributedText.addAttributes(boldAttribute,  range: NSRange(location: 0, length: splitTitleArray[1].length))
        
        let titleAttributedString = NSMutableAttributedString(string: splitTitleArray[0], attributes: [NSFontAttributeName:UIFont(name: "Avenir Next", size: size)!])
        titleAttributedString.appendAttributedString(attributedText)
        
        return titleAttributedString
    }
}