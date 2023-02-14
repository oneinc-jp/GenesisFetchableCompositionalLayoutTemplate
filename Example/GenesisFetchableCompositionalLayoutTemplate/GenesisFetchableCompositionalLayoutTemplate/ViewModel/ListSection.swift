//
//  ExampleSection.swift
//  GenesisCompositionalLayoutTemplate
//
//  Created by Akira Matsuda on 2023/02/11.
//

import CompositionalLayoutViewController
import UIKit

struct ListItem: Hashable {
    let title: String
    private let identifier = UUID()
}

class ListSection<ViewModel: Hashable>: CollectionViewSection {
    var snapshotItems: [AnyHashable] {
        return items
    }

    let items: [ViewModel]
    private let appearance: UICollectionLayoutListConfiguration.Appearance
    private let cellCongicuration: (UICollectionViewListCell, ViewModel) -> UIListContentConfiguration
    private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, ViewModel>!

    init(items: [ViewModel], cellCongicuration: @escaping ((UICollectionViewListCell, ViewModel) -> UIListContentConfiguration), appearance: UICollectionLayoutListConfiguration.Appearance = .plain) {
        self.items = items
        self.appearance = appearance
        self.cellCongicuration = cellCongicuration
        prepare()
    }

    private func prepare() {
        cellRegistration = UICollectionView.CellRegistration<
            UICollectionViewListCell,
            ViewModel
        > { [weak self] cell, _, item in
            guard let self else { return }
            cell.contentConfiguration = self.cellCongicuration(cell, item)
        }
    }

    func registerCell(collectionView: UICollectionView) {}

    func registerSupplementaryView(collectionView: UICollectionView) {}

    func layoutSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        return NSCollectionLayoutSection.list(
            using: UICollectionLayoutListConfiguration(appearance: appearance),
            layoutEnvironment: environment
        )
    }

    func cell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        return collectionView.dequeueConfiguredReusableCell(
            using: cellRegistration,
            for: indexPath,
            item: items[indexPath.row]
        )
    }

    func supplementaryView(_ collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        return nil
    }

    func configureSupplementaryView(_ view: UICollectionReusableView, indexPath: IndexPath) {}
}
