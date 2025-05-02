//
//  CriptoListCell.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 01/05/25.
//

import UIKit

class CriptoListCell: UITableViewCell {
    
    // MARK: - Properties
    var viewModelCell: CriptoListCellViewModel? {
        didSet {
            viewModelCell?.cancelImageDownload()
        }
    }
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameLabel: UILabel = UILabel.make(font: .boldSystemFont(ofSize: 14))
    
    private lazy var idLabel: UILabel = UILabel.make(font: .boldSystemFont(ofSize: 14))
    
    private lazy var volumeLabel: UILabel = UILabel.make(font: .boldSystemFont(ofSize: 20))
    
    
    private lazy var exchangeStackView:  UIStackView = UIStackView.make(alignment: .leading, spacing: Spacing.space2)
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Setup Data
    func setup(with viewModel: CriptoListCellViewModel) {
        nameLabel.text = viewModel.name
        volumeLabel.text = viewModel.dailyVolumeUsdText
        iconImage.image = viewModel.exchangeIconImage
        idLabel.text = viewModel.id
        
        viewModelCell?.onLogoImageUpdated = { [weak self] image in
            DispatchQueue.main.async {
                self?.iconImage.image = image
            }
        }
    }
    
    // MARK: - View Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModelCell?.cancelImageDownload()
    }
    
    // MARK: - Setup Methods
    private func setupViews() {
        setupVisualAppearance()
        exchangeStackView.addArrangedSubviews(idLabel, volumeLabel)
        addSubviews(iconImage, nameLabel, exchangeStackView)
        setupConstraints()
    }
    
    private func setupVisualAppearance() {
        backgroundColor = Colors.gray.color
        layer.cornerRadius = 16
        layer.masksToBounds = true
        selectionStyle = .none
    }
    
    func setupConstraints() {
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        exchangeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.space5),
            iconImage.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.space5),
            iconImage.widthAnchor.constraint(equalToConstant: 32),
            iconImage.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: Spacing.space1),
            nameLabel.centerYAnchor.constraint(equalTo: iconImage.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            exchangeStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.space5),
            exchangeStackView.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: Spacing.space2),
            exchangeStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.space5)
        ])
    }
    
    
}
