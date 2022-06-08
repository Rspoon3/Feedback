//
//  ViewController.swift
//  Feedback
//
//  Created by Richard Witherspoon on 6/8/22.
//

import UIKit
import Algorithms

class ViewController: UIViewController, UICollectionViewDelegate, UIScrollViewDelegate {
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    let contentOffsetSynchronizer = ContentOffsetSynchronizer()

    enum Section: Hashable {
        case main(id: UUID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
        applyInitialSnapshot()
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                               heightDimension: .fractionalHeight(0.25))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        DispatchQueue.main.async {
            self.registerScrollViewsForHorizontalScrollSyncing()
        }
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Int> { (cell, indexPath, int) in
            var content = cell.defaultContentConfiguration()
            content.text = int.description
            content.textProperties.font = .preferredFont(forTextStyle: .title1)
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfig.backgroundColor = .systemBlue.withAlphaComponent(0.25)
            cell.backgroundConfiguration = backgroundConfig
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Int) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
    
    func applyInitialSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        
        for chunk in Array(0..<80).chunks(ofCount: 10) {
            let section = Section.main(id: UUID())
            snapshot.appendSections([section])
            snapshot.appendItems(Array(chunk), toSection: section)
        }
        
        dataSource.apply(snapshot)
    }
    

    //MARK: - Workaround
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        registerScrollViewsForHorizontalScrollSyncing()
    }

    private func registerScrollViewsForHorizontalScrollSyncing() {
        let scrollViews = collectionView.subviews.compactMap({$0 as? UIScrollView})
        
        for scrollView in scrollViews {
            self.contentOffsetSynchronizer.register(scrollView)
        }
    }
}
