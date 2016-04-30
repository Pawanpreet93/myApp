
import UIKit

@IBDesignable
class LanguagesGraph: UIView {
    
    private let colorsArray = [Colors.blueish,Colors.yellowish,Colors.reddish,Colors.greenish,Colors.cyanish,Colors.pinkish]

    private let percentageArray = [0.5,0.6,0.65,0.75,0.85,0.9]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    
    override func drawRect(rect: CGRect) {
        // Add ARCs
        for i in 0...5{
              self.addCirle(50 + CGFloat(i * 35), capRadius: 12, color: self.colorsArray[i],percent:CGFloat(self.percentageArray[i]))
        }
    }
  
    
    func addCirle(arcRadius: CGFloat, capRadius: CGFloat, color: UIColor, percent:CGFloat) {
        let X = CGRectGetMidX(self.bounds)
        let Y = CGRectGetMidY(self.bounds)

        let pathBottom = UIBezierPath(ovalInRect: CGRectMake((X - (arcRadius/2)), (Y - (arcRadius/2)), arcRadius, arcRadius)).CGPath
        self.addOval(12.0, path: pathBottom, strokeStart: 0.0, strokeEnd: percent - 0.25, strokeColor: color, fillColor: UIColor.clearColor(), shadowRadius: 0, shadowOpacity: 0, shadowOffsset: CGSizeZero)
        
        // Top Oval
        let pathTop = UIBezierPath(ovalInRect: CGRectMake((X - (arcRadius/2)), (Y - (arcRadius/2)), arcRadius, arcRadius)).CGPath
        self.addOval(12.0, path: pathTop, strokeStart: 0.75, strokeEnd: 1.0, strokeColor: color, fillColor: UIColor.clearColor(), shadowRadius: 0, shadowOpacity: 0, shadowOffsset: CGSizeZero)
    }
    
    
    
    func addOval(lineWidth: CGFloat, path: CGPathRef, strokeStart: CGFloat, strokeEnd: CGFloat, strokeColor: UIColor, fillColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffsset: CGSize) {
        
        let arc = CAShapeLayer()
        arc.lineWidth = lineWidth
        arc.path = path
        arc.strokeStart = strokeStart
        arc.strokeEnd = strokeEnd
        arc.strokeColor = strokeColor.CGColor
        arc.fillColor = fillColor.CGColor
        arc.shadowColor = UIColor.blackColor().CGColor
        arc.shadowRadius = shadowRadius
        arc.shadowOpacity = shadowOpacity
        arc.shadowOffset = shadowOffsset        
       layer.addSublayer(arc)
        
    }
}
