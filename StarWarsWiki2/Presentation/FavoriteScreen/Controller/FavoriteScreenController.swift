// 
//  FavoriteScreenController.swift
//  StarWarsWiki2
//
//  Created by Иван Гришин on 07.08.2023.
//

import UIKit

final class FavoriteScreenController: UIViewController {
    
    // MARK: - Private Properties
    
    private let services: ServiceLayer
    private let mainView = FavoriteScreenView()
    
    // MARK: - Initializer
    
    init(services: ServiceLayer = ServiceLayer.shared) {
        self.services = services
        super.init(nibName: nil, bundle: nil)
        mainView.setupCollectionDelegates(delegate: self, dataSource: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.reloadCollection()
    }
    
    // MARK: - Private Methods
    
    private func showAlertForRemove(indexPath: IndexPath) {
        let alertVC = UIAlertController(title: "Delete?", message: nil, preferredStyle: .alert)
        alertVC.addAction(
            .init(
                title: "Yes",
                style: .destructive,
                handler: { [weak self] _ in
                    self?.services.localStorage.favorites.remove(at: indexPath.item)
                    self?.mainView.removeItem(at: indexPath)
                }
            )
        )
        alertVC.addAction(.init(title: "No", style: .cancel))
        present(alertVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension FavoriteScreenController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        services.localStorage.favorites.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: FavoriteScreenViewCell = collectionView.dequeueCell(for: indexPath)
        cell.configureCell(services.localStorage.favorites[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension FavoriteScreenController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showAlertForRemove(indexPath: indexPath)
    }
}
