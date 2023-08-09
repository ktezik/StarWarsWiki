//
//  AppViewController.swift
//  StarWarsWiki2
//
//  Created by Иван Гришин on 07.08.2023.
//

import UIKit

/// Сущность управляющая состоянием приложения.
final class AppViewController: UIViewController {

    // MARK: - Private Properties

    private let localStorage: LocalStorage
    private let rootViewController = TabBarViewController()

    // MARK: - Init

    init(localStorage: LocalStorage = ServiceLayer.shared.localStorage) {
        self.localStorage = localStorage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(controller: rootViewController, rootView: view)
    }
}
