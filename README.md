# Equal Heights CollectionView Groups Using UICollectionViewCompositionalLayout

Feedback ID: FB10104289  
Status: Open  
Date Submitted: 6-8-2022

## Summary 
I have a UICollectionViewLayout grid with three columns. Each item in the column has a cell full of text. I would like all the columns to be the same height as the tallest item in the group. Using `UICollectionViewCompositionalLayout` I'm having a hard time getting the desired results.

## Current Behavior
I created a `EqualHeightsUICollectionViewCompositionalLayout` subcalss to check the cell attributes in `layoutAttributesForElements` and stores the largest cell height in a row. This seems to work good intially, but when the collectionview invalidates, the cell sizes are not always correct.


https://user-images.githubusercontent.com/42879920/172652464-8fed381c-4d83-4d7c-a239-ca807720b273.mov


```swift
class EqualHeightsUICollectionViewCompositionalLayout: UICollectionViewCompositionalLayout{
    var largestDict: [Int: CGFloat] = [:]
    let columns = 3

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        if let attributes = attributes {
            for attribute in attributes {
                let height = attribute.frame.height
                let row = attribute.indexPath.row / columns
                
                if height > 1 {
                    self.largestDict[row] = max(height, largestDict[row] ?? 0)
                }
            }
        }
        
        return attributes
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        largestDict.removeAll()
    }
}
```

```swift
class TextCell: UICollectionViewCell {
    let label = UILabel()
    let bottomLabel = UILabel()
    let container = UIView()
    weak var collectionView: UICollectionView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attribute = super.preferredLayoutAttributesFitting(layoutAttributes)
        
        if let layout = collectionView?.collectionViewLayout as? EqualHeightsUICollectionViewCompositionalLayout{
            let row = attribute.indexPath.row / layout.columns
            
            if let height = layout.largestDict[row] {
                attribute.frame = .init(origin: attribute.frame.origin, size: .init(width: attribute.frame.width, height: height))
            }
        }
        
        return attribute
    }
    
    private func configure() {
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.backgroundColor = .systemPurple
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        bottomLabel.numberOfLines = 0
        bottomLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        bottomLabel.text = "Bottom of cell"
        bottomLabel.backgroundColor = .systemRed
        bottomLabel.textColor = .white
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        contentView.addSubview(label)
        contentView.addSubview(bottomLabel)
        
        backgroundColor = .systemBlue.withAlphaComponent(0.75)
        
        let inset = CGFloat(0)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            
            bottomLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            bottomLabel.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            bottomLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: inset),
            bottomLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
        ])
    }
}

```


## Desired Behavior
The cells in a row are always the height of the largest in the row.


## Version/Build
- Xcode 13.4.1 (13F100)
- iPad 12.9 15.5 (5th generation)
