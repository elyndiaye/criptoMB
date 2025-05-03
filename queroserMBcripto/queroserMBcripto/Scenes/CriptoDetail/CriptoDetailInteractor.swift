//
//  CriptoDetailInteractor.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 02/05/25.
//  
//

import Foundation

class CriptoDetailInteractor {
    
    // MARK: Properties
    private let presenter: CriptoDetailPresenterProtocol
    private let exchange: ExchangeModel
    
    init(presenter: CriptoDetailPresenterProtocol, exchange: ExchangeModel) {
        self.presenter = presenter
        self.exchange = exchange
    }
}

extension CriptoDetailInteractor: CriptoDetailInteractorProtocol {
    func openUrl() {
        if let website = exchange.website, let url = URL(string: website) {
            presenter.openUrl(url: url)
        }
    }
    
    func setupDetail() {
        presenter.showDataDetail(exchange: exchange)
    }
    
}
