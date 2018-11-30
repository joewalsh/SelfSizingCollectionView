import UIKit

class Cell: UICollectionViewCell {
    let label = UILabel()
    
    var fixedWidth: CGFloat = 50 {
        didSet {
            widthConstraint.constant = fixedWidth
            label.preferredMaxLayoutWidth = fixedWidth
        }
    }
    
    lazy var widthConstraint: NSLayoutConstraint = {
        let constraint = contentView.widthAnchor.constraint(equalToConstant: fixedWidth)
        constraint.priority = UILayoutPriority(rawValue: 999)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor.white
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = fixedWidth
        contentView.addConstrainedSubview(label)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        label.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        fixedWidth = layoutAttributes.bounds.size.width
        super.apply(layoutAttributes)
    }
}
