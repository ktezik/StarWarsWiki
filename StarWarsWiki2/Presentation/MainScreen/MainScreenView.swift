// 
//  MainScreenView.swift
//  StarWarsWiki2
//
//  Created by Иван Гришин on 07.08.2023.
//

import UIKit

protocol MainScreenViewDelegate: AnyObject {
    func didChangeSegment(type: ModelType)
}

final class MainScreenView: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let segmentControlHeight: CGFloat = 45.fitH
        static let segmentControlHorizontalInset: CGFloat = 5.fitW
        static let searchBarTopInset: CGFloat = 5.fitH
        static let collectionInsets: UIEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        static let collectionItemSize: CGSize = .init(width: UIScreen.main.bounds.width / 2 - 10, height: 100)
    }
    
    // MARK: - Private Properties
    
    private weak var delegate: MainScreenViewDelegate?
    
    private var spinner = UIActivityIndicatorView(style: .large)
    
    private let collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = Constants.collectionItemSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .lightGray
        collectionView.register(cell: MainScreenViewCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.collectionInsets
        collectionView.allowsMultipleSelection = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ModelType.allCases.map({ $0.rawValue }))
        segmentControl.selectedSegmentTintColor = UIColor(hexString: "74BBE2")
        segmentControl.backgroundColor = .darkGray
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.tintColor = .lightGray
        searchBar.barTintColor = .lightGray
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    // MARK: - Initializer
    
    init(delegate: MainScreenViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func showLoader() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        spinner.startAnimating()
        collectionView.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            spinner.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func hideLoader() {
        spinner.removeFromSuperview()
    }
    
    func reloadCollection() {
        collectionView.reloadData()
    }
    
    func setupCollectionDelegates(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
    
    func resetUI(needResetSearch: Bool = false) {
        searchBar.resignFirstResponder()
        if needResetSearch {
            searchBar.text = ""
        }
    }
    
    func setupSearchBar(delegate: UISearchBarDelegate) {
        searchBar.delegate = delegate
    }
    
    // MARK: - Actions
    
    @objc private func segmentControlAction(_ sender: UISegmentedControl) {
        delegate?.didChangeSegment(type: ModelType.allCases[sender.selectedSegmentIndex])
    }
    
    // MARK: - Private Methods
    
    private func setupGesture() {
        segmentControl.addTarget(self, action: #selector(segmentControlAction(_:)), for: .valueChanged)
    }
    
    private func configureView() {
        backgroundColor = .lightGray
        addSubviews()
        configureLayout()
        setupGesture()
        segmentControl.selectedSegmentIndex = 0
    }
    
    private func addSubviews() {
        [segmentControl, searchBar, collectionView].forEach({ addSubview($0) })
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            segmentControl.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.segmentControlHorizontalInset
            ),
            segmentControl.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.segmentControlHorizontalInset
            ),
            segmentControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            segmentControl.heightAnchor.constraint(equalToConstant: Constants.segmentControlHeight),

            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: Constants.searchBarTopInset),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor)
        ])
    }
}
