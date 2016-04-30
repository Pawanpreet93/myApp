
import UIKit

private let reuseIdentifier = "LanguageCell"

class LanguagesDetailCollectionViewController: UICollectionViewController {

    private let languagesArray = ["Swift", "C#", "C/C++", "HTML", "CSS", "JavaScript"]
    private let percentageArray = [75.0,50.0,60.0,90.0,85.0,65.0]
    private let backgroundImages = ["swiftBack","c#Back","cBack","htmlBack","cssBack","jsBack"]
    
    private var cellShown = [Bool](count:6, repeatedValue:false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationLabel = UILabel()
        navigationLabel.attributedText = AtributedTitleText.MakeAtributedTitleString("languages Detail",size: 20.0)
        navigationLabel.textColor = UIColor.whiteColor()
        navigationLabel.sizeToFit()
        self.navigationItem.titleView = navigationLabel
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return languagesArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as!LanguagesCollectionViewCell
        
        cell.languageTitleLabel.text = languagesArray[indexPath.row]
        cell.backgroundImage.image = UIImage(named: backgroundImages[indexPath.row])
        cell.graphView.percentage = (percentageArray[indexPath.row] - 25.0) / 100
        
        cell.percentageLabel.text = "\(Int(percentageArray[indexPath.row]))%"

        cell.backView.layer.cornerRadius = 20
        
        if !cellShown[indexPath.row]{
            cell.transform = CGAffineTransformMakeScale(0, 0)
            cell.transform = CGAffineTransformMakeScale(0, 0)
            
            UIView.animateWithDuration(0.4, delay: Double(indexPath.row)*0.4, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                
                cell.transform = CGAffineTransformMakeScale(1.3, 1.3)
                cell.transform = CGAffineTransformMakeScale(1.3, 1.3)
                
                cell.transform = CGAffineTransformMakeScale(1.0, 1.0)
                cell.transform = CGAffineTransformMakeScale(1.0, 1.0)
                
                }, completion: nil)
            
            cellShown[indexPath.row] = true
        }

        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
              return true
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        for   i in 0..<languagesArray.count{
            
            let eachIndexPath = NSIndexPath(forRow: i, inSection: 0)
            let cell = collectionView.cellForItemAtIndexPath(eachIndexPath) as! LanguagesCollectionViewCell
            
            if eachIndexPath == indexPath{
                
                
                cell.graphView.hidden = false
                
                UIView.animateWithDuration(0.4, delay: 0, options: [.AllowUserInteraction, .CurveEaseInOut], animations: { () -> Void in
                    cell.languageTitleLabel.alpha = 0
                    }, completion: nil)

                
                cell.graphView.layer.opacity = 0.0
                UIView.animateWithDuration(0.7, delay: 0.5, options: [.AllowUserInteraction, .CurveEaseInOut], animations: { () -> Void in
                      cell.graphView.layer.opacity = 1
                    }, completion: nil)
                
                
            }
            else{
                UIView.animateWithDuration(0.4, delay: 0.4, options: [.AllowUserInteraction, .CurveEaseInOut], animations: { () -> Void in
                    cell.languageTitleLabel.alpha = 1
                    }, completion: nil)
                
                UIView.animateWithDuration(0.4, delay: 0, options: [.AllowUserInteraction, .CurveEaseInOut], animations: { () -> Void in
                    cell.graphView.layer.opacity = 0.0
                    }, completion: nil)
            }

        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
   
    
 

}
