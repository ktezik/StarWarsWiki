// 
//  BorderedCollectionViewCell.swift
//  StarWarsWiki2
//
//  Created by Иван Гришин on 09.08.2023.
//

import UIKit

class BorderedCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    override var isSelected: Bool {
        didSet {
            if isEditable {
                /// При isSelected = true ячейке добавляется фиолетовая рамка
                return isSelected ? addBorderForSelectedCell() : removeBorderForUnselectedCell()
            }
        }
    }
    
    /// Флаг отвечает за возможность выделения ячейки
    var isEditable = true
    /// Значение радиуса
    var radius: CGFloat = 10
    
    // MARK: - Private Properties
    
    private let starImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal))
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupStarImage() {
        contentView.addSubview(starImage)
        NSLayoutConstraint.activate([
            starImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            starImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            starImage.widthAnchor.constraint(equalToConstant: 16),
            starImage.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    /// Добавляем рамку выбранной ячейке
    private func addBorderForSelectedCell() {
        setupStarImage()
        UIView.animate(withDuration: 0.3) {
            self.contentView.layer.borderColor = UIColor.yellow.cgColor
            self.contentView.layer.borderWidth = 2
            self.contentView.layer.cornerRadius = self.radius
            self.contentView.layer.cornerCurve = .continuous
            self.starImage.alpha = 1
        }
    }
    
    /// Убираем рамку у невыбранной ячейки
    private func removeBorderForUnselectedCell() {
        UIView.animate(withDuration: 0.3) {
            self.starImage.alpha = 0
            self.contentView.layer.borderColor = UIColor.clear.cgColor
        } completion: { _ in
            self.starImage.removeFromSuperview()
        }
    }
}
