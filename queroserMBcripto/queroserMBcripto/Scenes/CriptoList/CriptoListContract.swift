//
//  CriptoListContract.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 01/05/25.
//  
//

import Foundation

// MARK: - Coordinator Protocol
protocol CriptoListCoordinatorProtocol: AnyObject {
    func navigateToDetailsScene(exchanges: ExchangeModel, exchangesImage: ExchangeImageModel)
}

// MARK: View Output (Presenter -> View)
protocol CriptoListPresenterProtocol: AnyObject {
    func showExchangeList(exchanges: [ExchangeModel], exchangesIcon: [ExchangeImageModel])
    func showDetails(exchanges: ExchangeModel, exchangesIcon: ExchangeImageModel)
    func showError()
}


// MARK: - CriptoListInteractor Protocol
protocol CriptoListInteractorProtocol: AnyObject {
    func loadExchangeList()
    func showDetails(indexPath: IndexPath)
}
