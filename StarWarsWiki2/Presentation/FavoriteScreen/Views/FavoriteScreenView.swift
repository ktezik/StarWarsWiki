// 
//  FavoriteScreenView.swift
//  StarWarsWiki2
//
//  Created by Иван Гришин on 09.08.2023.
//

import UIKit

final class FavoriteScreenView: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let collectionInsets: UIEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        static let collectionItemSize: CGSize = .init(width: UIScreen.main.bounds.width / 2 - 10, height: 100)
    }
    
    // MARK: - Private Properties
    
    private let collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = Constants.collectionItemSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .lightGray
        collectionView.register(cell: FavoriteScreenViewCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.collectionInsets
        collectionView.allowsMultipleSelection = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func removeItem(at indexPath: IndexPath) {
        collectionView.deleteItems(at: [indexPath])
    }
    
    func reloadCollection() {
        collectionView.reloadData()
    }
    
    func setupCollectionDelegates(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        backgroundColor = .lightGray
        addSubviews()
        configureLayout()
    }
    
    private func addSubviews() {
        [collectionView].forEach({ addSubview($0) })
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        ])
    }
}
