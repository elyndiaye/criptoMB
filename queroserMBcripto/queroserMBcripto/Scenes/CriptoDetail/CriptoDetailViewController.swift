//
//  CriptoDetailViewController.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 02/05/25.
//  
//

import UIKit

protocol CriptoDetailViewControllerProtocol: AnyObject {
    func displayDetail(exchange: ExchangeModel)
}

class CriptoDetailViewController: UIViewController {
    private let interactor: CriptoDetailInteractorProtocol
    
    
    private(set) lazy var nameLabel: UILabel = UILabel.make(font: .boldSystemFont(ofSize: Spacing.space6))
    
    private(set) lazy var idLabel: UILabel = UILabel.make(font: .boldSystemFont(ofSize: Spacing.space6))
    
    private(set) lazy var dailyVolumeUsdLabel: UILabel = UILabel.make(font: .boldSystemFont(ofSize: Spacing.space6))
    
    private lazy var buttonUrl: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.darkGray
        button.setTitle("Acessar Exchange", for: .normal)
        button.addTarget(self, action: #selector(openUrl), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Spacing.space3
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        interactor.setupDetail()
    }
    
    // MARK: - Initializers
    init(interactor: CriptoDetailInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    @objc
    private func openUrl() {
        interactor.openUrl()
    }
}


extension CriptoDetailViewController: SetupView {
    func setupHierarchy() {
        stackView.addArrangedSubviews(nameLabel, idLabel, dailyVolumeUsdLabel, buttonUrl)
        view.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Spacing.space3),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space3),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space3)
        ])
        
        NSLayoutConstraint.activate([
            buttonUrl.heightAnchor.constraint(equalToConstant: Spacing.space7)
        ])
    }
}

extension CriptoDetailViewController: CriptoDetailViewControllerProtocol {
    func displayDetail(exchange: ExchangeModel) {
        nameLabel.text = exchange.name ?? ""
        idLabel.text = exchange.exchangeId
        dailyVolumeUsdLabel.text = NumberFormatter.currency.string(fromValue: exchange.volume1dayUsd ?? 0)
        buttonUrl.isHidden = exchange.website == nil
    }
}
