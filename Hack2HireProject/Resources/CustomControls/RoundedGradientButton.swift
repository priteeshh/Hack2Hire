
import UIKit

class RoundedGradientButton: UIButton {
    
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = true

        // Horizontal gradient
        gradientLayer.colors = [ Theme.Color.accent.cgColor, Theme.Color.tint.cgColor ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
        
        layer.borderWidth = 1
        layer.borderColor = Theme.Color.tint.cgColor
        
        setTitleColor(Theme.Color.textOnDark, for: .normal)
    }
    
    // Use this function so the gradient layer resizes when changing orientation
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        layer.cornerRadius = bounds.height / 2
    }
    
    // MARK: - Button Flash Animation
    var alphaBefore: CGFloat = 1
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        alphaBefore = alpha
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: {
            self.alpha = 0.4
        })
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        UIView.animate(withDuration: 0.35, delay: 0, options: .allowUserInteraction, animations: {
            self.alpha = self.alphaBefore
        })
    }
}
