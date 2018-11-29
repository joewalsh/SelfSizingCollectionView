import UIKit

class Cell: UICollectionViewCell {
    let label = UILabel()
    
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
        label.preferredMaxLayoutWidth = 300
        contentView.addConstrainedSubview(label)
        let widthConstraint = contentView.widthAnchor.constraint(equalToConstant: 300)
        widthConstraint.priority = UILayoutPriority(rawValue: 999)
        NSLayoutConstraint.activate([widthConstraint])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        label.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
    }
}
