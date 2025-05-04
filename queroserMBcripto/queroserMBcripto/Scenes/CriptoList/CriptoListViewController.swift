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
    func displayError(apiError: ApiError)
    func stopLoading()
}

class CriptoListViewController: UIViewController {
    // MARK: - Properties
    private let interactor: CriptoListInteractorProtocol
    
    private(set) lazy var exchangeListTable: CriptoListTableView = {
        let tableView = CriptoListTableView()
        tableView.criptoListTableViewDelegate = self
        return tableView
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
}

extension CriptoListViewController: SetupView {
    func setupHierarchy() {
        view.addSubviews(activityIndicator, exchangeListTable)
    }
    
    func setupConstraints() {
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
    }
    
    func setupStyles() {
        view.backgroundColor = Colors.black.color
        exchangeListTable.accessibilityIdentifier = "CriptoListTableViewAccessibilityIdentifier"
        activityIndicator.accessibilityIdentifier = "SomeUniqueIdentifierForActivityIndicator"
        exchangeListTable.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        exchangeListTable.isHidden = false
    }
    
    func startLoading() {
        exchangeListTable.isHidden = true
        activityIndicator.startAnimating()
    }
    
}

extension CriptoListViewController: CriptoListTableViewDelegate{
    func didTapExchange(at indexPath: IndexPath) {
        interactor.showDetails(indexPath: indexPath)
    }
}

// MARK: - CriptoListViewControllerProtocol
extension CriptoListViewController: CriptoListViewControllerProtocol{
    func displayList(exchangeList: [CriptoListCellViewModel]) {
        exchangeListTable.exchangeList = exchangeList
        exchangeListTable.reloadData()
        stopLoading()
    }
    
    func displayError(apiError: ApiError) {
        DispatchQueue.main.async {
              self.activityIndicator.stopAnimating()
              
              let alert = UIAlertController(
                  title: CriptoStrings.somethingWrong,
                  message: apiError.message,
                  preferredStyle: .alert
              )
              
              let action = UIAlertAction(title: CriptoStrings.tryAgain, style: .default) { _ in
                  self.startLoading()
                  self.interactor.loadExchangeList()
              }
              
              alert.addAction(action)
              self.present(alert, animated: true)
          }
    }
    
}
