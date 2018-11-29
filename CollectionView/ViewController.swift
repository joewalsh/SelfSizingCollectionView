import UIKit

extension UIView {
    func addConstrainedSubview(_ subview: UIView, with insets: NSDirectionalEdgeInsets = .zero, priority: UILayoutPriority = .required) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top)
        topConstraint.priority = priority
        let bottomConstraint = bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: insets.bottom)
        bottomConstraint.priority = priority
        let leftConstraint = subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.leading)
        leftConstraint.priority = priority
        let rightConstraint = trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: insets.trailing)
        rightConstraint.priority = priority
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
    }
}

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
        NSLayoutConstraint.activate([widthConstraint])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        label.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
    }
}

let dictionary = ["lorem", "ipsum", "is", "simply", "dummy", "text", "of", "the", "printing", "and", "typesetting", "industry"]

class ViewController: UIViewController {
    var data: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumInteritemSpacing = 1
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .gray
        view.addConstrainedSubview(collectionView)
        let count = 1000
        var updatedData: [String] = []
        updatedData.reserveCapacity(count)
        for _ in 1...count {
            let rand = Int(arc4random_uniform(100)) + 10
            var sentence: [String] = []
            sentence.reserveCapacity(rand)
            for _ in 0...rand {
                let wordIndex = Int(arc4random_uniform(UInt32(dictionary.count)))
                let word = dictionary[wordIndex]
                sentence.append(word)
            }
            updatedData.append(sentence.joined(separator: " "))
        }
        data = updatedData
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let maybeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let cell = maybeCell as? Cell else {
            return maybeCell
        }
        cell.label.text = data[indexPath.row]
        return cell
    }
}
