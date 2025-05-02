//
//  CriptoListViewController.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 01/05/25.
//  
//

import UIKit

// MARK: - Protocols
protocol CriptoListViewControllerProtocol: AnyObject {
    func displayList(exchangeList: [CriptoListCellViewModel])
    func displayError()
}

class CriptoListViewController: UIViewController {
    // MARK: - Properties
    private let interactor: CriptoListInteractorProtocol
    
    private(set) lazy var exchangeListTable: CriptoListTableView = {
        let tableView = CriptoListTableView()
        tableView.criptoListTableViewDelegate = self
        return tableView
    }()

    private lazy var errorFetchListLabel: UILabel = UILabel.make(font: UIFont.boldSystemFont(ofSize: 32),
                                                                         text: "Não foi possível carregar as informações",
                                                                         textAlignment: .center)
    
    private lazy var errorStackView: UIStackView = UIStackView.make(distribution: .fillProportionally,
                                                                         spacing: Spacing.space2)
    
    private lazy var retryFetchListButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tentar novamente", for: .normal)
        button.setTitleColor(Colors.gray.color, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(retryFetchList), for: .touchUpInside)
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .large
        activity.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    // MARK: - Initializers
    init(interactor: CriptoListInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        interactor.loadExchangeList()
    }

    @objc func retryFetchList() {
        interactor.loadExchangeList()
    }
}

extension CriptoListViewController: SetupView {
    func setupHierarchy() {
        errorStackView.addArrangedSubviews(errorFetchListLabel,
                                           retryFetchListButton)
        view.addSubviews(activityIndicator, errorStackView, exchangeListTable)
    }

    func setupConstraints() {
        errorStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            exchangeListTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Spacing.space2),
            exchangeListTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            exchangeListTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space3),
            exchangeListTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space3)
        ])

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            errorStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space3),
            errorStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space3)
        ])

    }

    func setupStyles() {
        view.backgroundColor = Colors.black.color
//        let backItem = UIBarButtonItem()
//        backItem.title = "Voltar"
//        navigationItem.backBarButtonItem = backItem
        exchangeListTable.accessibilityIdentifier = "CriptoListTableViewAccessibilityIdentifier"
        activityIndicator.accessibilityIdentifier = "SomeUniqueIdentifierForActivityIndicator"
        exchangeListTable.isHidden = true
        errorStackView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        exchangeListTable.isHidden = false
        errorStackView.isHidden = true
    }
    
}


extension CriptoListViewController: CriptoListTableViewDelegate{
    func didTapExchange(at indexPath: IndexPath) {
        //Call Presenter and todo
        print("TODO")
    }
    
}

// MARK: - CriptoListViewControllerProtocol
extension CriptoListViewController: CriptoListViewControllerProtocol{
    func displayList(exchangeList: [CriptoListCellViewModel]) {
        exchangeListTable.exchangeList = exchangeList
        exchangeListTable.reloadData()
        stopLoading()
    }
    
    func displayError() {
       activityIndicator.stopAnimating()
        errorStackView.isHidden = false
    }
    
}
