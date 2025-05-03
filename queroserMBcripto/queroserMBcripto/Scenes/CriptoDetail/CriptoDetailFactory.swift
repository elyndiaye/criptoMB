//
//  CriptoDetailFactory.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 02/05/25.
//

import UIKit

enum CriptoDetailFactory {
    static func make(exchange: ExchangeModel) -> CriptoDetailViewController {
        let presenter: CriptoDetailPresenterProtocol = CriptoDetailPresenter()
        let interactor = CriptoDetailInteractor(presenter: presenter, exchange: exchange)
        let viewController = CriptoDetailViewController(interactor: interactor)
    
        presenter.viewController = viewController
        
        return viewController
    }
}
