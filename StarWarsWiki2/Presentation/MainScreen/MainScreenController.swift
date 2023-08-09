// 
//  MainScreenController.swift
//  StarWarsWiki2
//
//  Created by Иван Гришин on 07.08.2023.
//

import UIKit

final class MainScreenController: UIViewController {
    
    // MARK: - Private Properties
    
    private let services: ServiceLayer
    private let model: MainScreenModelProtocol
    private lazy var mainView = MainScreenView(delegate: self)
    
    // MARK: - Initializer
    
    init(model: MainScreenModelProtocol = MainScreenModel(), services: ServiceLayer = ServiceLayer.shared) {
        self.model = model
        self.services = services
        super.init(nibName: nil, bundle: nil)
        mainView.setupSearchBar(delegate: self)
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
}

// MARK: - UISearchBarDelegate

extension MainScreenController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        mainView.showLoader()
        model.updateModel(manager: services.apiManager, searchText: searchText) { [weak self] in
            guard let self else { return }
            self.mainView.hideLoader()
            self.mainView.reloadCollection()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainView.resetUI()
    }
}

// MARK: - MainScreenViewDelegate

extension MainScreenController: MainScreenViewDelegate {
    func didChangeSegment(type: ModelType) {
        mainView.resetUI(needResetSearch: true)
        model.changeModel(type: type)
        mainView.reloadCollection()
    }
}

// MARK: - UICollectionViewDataSource

extension MainScreenController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.items.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: MainScreenViewCell = collectionView.dequeueCell(for: indexPath)
        cell.configureCell(model.items[indexPath.item])
        if model.getFavoriteStatus(services.localStorage, indexPath: indexPath) {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MainScreenController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainView.resetUI()
        model.addToFavorite(services.localStorage, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        mainView.resetUI()
        model.removeFromStorage(services.localStorage, indexPath: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mainView.resetUI()
    }
}
