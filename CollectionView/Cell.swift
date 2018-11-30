import UIKit

class Cell: UICollectionViewCell {
    let label = UILabel()
    lazy var widthConstraint: NSLayoutConstraint = {
        let constraint = contentView.widthAnchor.constraint(equalToConstant: contentView.frame.size.width)
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
        label.preferredMaxLayoutWidth = contentView.frame.size.width
        contentView.addConstrainedSubview(label)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        label.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        widthConstraint.constant = layoutAttributes.bounds.width
        super.apply(layoutAttributes)
    }
}
