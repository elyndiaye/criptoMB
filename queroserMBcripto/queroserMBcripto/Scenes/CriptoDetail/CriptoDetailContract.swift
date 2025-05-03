//
//  CriptoDetailContract.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 02/05/25.
//  
//

import Foundation

// MARK: Interactor - Protocol
protocol CriptoDetailInteractorProtocol: AnyObject {
    func setupDetail()
    func openUrl()
}

// MARK: CriptoDetailPresenterProtocol - Presenter
protocol CriptoDetailPresenterProtocol: AnyObject {
    var viewController: CriptoDetailViewControllerProtocol? { get set }
    func showDataDetail(exchange: ExchangeModel)
    func openUrl(url: URL)
}
