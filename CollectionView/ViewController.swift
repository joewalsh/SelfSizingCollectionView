import UIKit

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
