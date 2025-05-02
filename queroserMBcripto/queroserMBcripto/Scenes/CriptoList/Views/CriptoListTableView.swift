//
//  CriptoListTableView.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 01/05/25.
//

import UIKit

// MARK: - Protocol
protocol CriptoListTableViewDelegate: AnyObject {
    func didTapExchange(at indexPath: IndexPath)
}


class CriptoListTableView: UITableView {
    
    weak var criptoListTableViewDelegate: CriptoListTableViewDelegate?
    var exchangeList: [CriptoListCellViewModel] = [] {
        didSet {
            reloadData()
        }
    }

    // MARK: - Initializers
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupTableView() {
        dataSource = self
        delegate = self
        register(CriptoListCell.self, forCellReuseIdentifier: "CriptoListCell")
        configureTableViewAppearance()
    }

    private func configureTableViewAppearance() {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 100
        backgroundColor = Colors.black.color
        separatorStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - UITableViewDataSource
extension CriptoListTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return exchangeList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: CriptoListCell.identifier, for: indexPath) as? CriptoListCell else {
            return UITableViewCell()
        }
        let viewModel = exchangeList[indexPath.section]
        cell.viewModelCell = viewModel
        cell.setup(with: viewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CriptoListTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.0 : Spacing.space0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let viewModel = exchangeList[indexPath.section]
        viewModel.fetchImage(from:viewModel.exchangeIconURL)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        criptoListTableViewDelegate?.didTapExchange(at: indexPath)
    }
}


extension CriptoListCell {
    static let identifier = "CriptoListCell"
}
