// 
//  FavoriteScreenViewCell.swift
//  StarWarsWiki2
//
//  Created by Иван Гришин on 09.08.2023.
//

import UIKit

final class FavoriteScreenViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private lazy var title = getLabel(font: .boldSystemFont(ofSize: 17))
    private lazy var firstSubtitle = getLabel(font: .systemFont(ofSize: 16))
    private lazy var secondSubtitle = getLabel(font: .systemFont(ofSize: 16))
    private lazy var thirdSubtitle = getLabel(font: .systemFont(ofSize: 16))
    
    private let typeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        title.text = nil
        firstSubtitle.text = nil
        secondSubtitle.text = nil
        thirdSubtitle.text = nil
    }
    
    // MARK: - Public Methods
    
    func configureCell(_ model: MainScreenCellModel) {
        title.text = model.title
        firstSubtitle.text = model.firstSubtitle
        secondSubtitle.text = model.secondSubtitle
        thirdSubtitle.text = model.thirdSubtitle
        typeImage.image = model.type.getTypeIcon()
    }
    
    // MARK: - Private Methods
    
    private func configureCell() {
        contentView.backgroundColor = .systemGray2
        contentView.layer.cornerRadius = 10
        contentView.layer.cornerCurve = .continuous
        addSubviews()
        configureLayout()
    }
    
    private func addSubviews() {
        [
            typeImage,
            title,
            firstSubtitle,
            secondSubtitle,
            thirdSubtitle
        ].forEach({ contentView.addSubview($0) })
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            
            firstSubtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            firstSubtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            firstSubtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            
            secondSubtitle.topAnchor.constraint(equalTo: firstSubtitle.bottomAnchor, constant: 4),
            secondSubtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            secondSubtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            
            thirdSubtitle.topAnchor.constraint(equalTo: secondSubtitle.bottomAnchor, constant: 4),
            thirdSubtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            thirdSubtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            
            typeImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            typeImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    private func getLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = .white
        label.textAlignment = .center
        label.minimumScaleFactor = 0.2
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
