//
//  ViewController.swift
//  Wakey Wakey
//
//  Created by Karsten Westra on 09/05/2022.
//

import UIKit
import SwiftUI
import Alamofire

private enum SearchResultListSection: Int {
    case main
}

private typealias SearchResultDataSource = UICollectionViewDiffableDataSource<SearchResultListSection, Video.ID>

class ViewController: UIViewController {

    private var presenter: SearchListPresenter!
    private var interactor: SearchListInteractor = SearchListInteractor()

    private var dataSource: SearchResultDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.backgroundColor = .green

        dataSource = self.createDataSource(collectionView: collectionView)
        collectionView.dataSource = dataSource

        view.addSubview(collectionView)
        self.anchor(collectionView: collectionView, to: view)

        presenter = SearchListPresenter(view: self, interactor: interactor)
        presenter.search(query: "wakeboard")
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }

        return layout
    }
    
    private func createDataSource(collectionView collection: UICollectionView) -> SearchResultDataSource {
        let searchResultRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Video> { cell, indexPath, video in
            if #available(iOS 16, *) {
                cell.contentConfiguration = UIHostingConfiguration {
                    HStack {
                        if let link = video.video_pictures.first?.picture {
                            AsyncImage(url: URL(string: link)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                                    .frame(width: 100, height: 100)
                        }
                        Text("\(video.id)")
                    }
                }
            } else {
                // TODO
            }
        }

        return SearchResultDataSource(collectionView: collection, cellProvider: { collectionView, indexPath, identifier -> UICollectionViewCell? in
            let video = ResultStorage.video(with: identifier)
            return collectionView.dequeueConfiguredReusableCell(using: searchResultRegistration, for: indexPath, item: video)
        })
    }

    private func anchor(collectionView newCollectionView: UICollectionView, to parentView: UIView) {
        newCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            newCollectionView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            newCollectionView.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor),
            newCollectionView.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor),
            newCollectionView.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension ViewController: SearchListView {
    public func show(result: VideoSearchResult) {
        ResultStorage.values = result.videos

        var snapshot = NSDiffableDataSourceSnapshot<SearchResultListSection, Video.ID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(ResultStorage.values.map { $0.id }, toSection: .main)
        self.dataSource.apply(snapshot)
    }
}
