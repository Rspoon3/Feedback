//
//  ViewController.swift
//  Feedback
//
//  Created by Richard Witherspoon on 6/8/22.
//

import UIKit

import UIKit
//https://stackoverflow.com/questions/71918534/make-nscollectionlayoutitem-heights-as-tall-as-the-nscollectionlayoutgroup-when

class ViewController: UIViewController {
    let sentences = [
        "This is a short sentence for a short string",
        "This week is WWDC and Im hoping that I can get some help with this long sentence so that it resizes properly. Maybe this should just be its own api? Idk I just need a long sentence for this to resize properly. Please be long enough now.",
        "I was able to mock this expected behavior by changing the NSCollectionLayoutSize to be an absolute value of 500. This is not what I want."
    ]
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
        applyInitialSnapshot()
    }
    
    func createLayout() -> UICollectionViewLayout {
        let spacing = CGFloat(10)

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        return EqualHeightsUICollectionViewCompositionalLayout(section: section)
    }
    
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<TextCell, String> { [weak self] (cell, indexPath, string) in
            cell.label.text = string
            let size = cell.label.sizeThatFits(.init(width: cell.frame.width, height: .infinity))
            print("Size ", size)
            cell.collectionView = self?.collectionView
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, string: String) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: string)
        }
    }
    
    func applyInitialSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(sentences)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
