//
//  CriptoListPresenter.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 01/05/25.
//  
//

import Foundation

final class CriptoListPresenter {
    
    // MARK: Properties
    weak var viewController: CriptoListViewControllerProtocol?
    private let coordinator: CriptoListCoordinatorProtocol
    
    init(coordinator: CriptoListCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
}

extension CriptoListPresenter: CriptoListPresenterProtocol {
    func showExchangeList(exchanges: [ExchangeModel], exchangesIcon: [ExchangeImageModel]) {
        let viewModels = exchanges.map { exchange in
            mapExchangeToViewModel(exchange: exchange, images: exchangesIcon)
        }
        viewController?.displayList(exchangeList: viewModels)
    }
    
    func showDetails(exchanges: ExchangeModel, exchangesIcon: ExchangeImageModel) {
        coordinator.navigateToDetailsScene(exchanges: exchanges, exchangesImage: exchangesIcon)
    }
    
    func showError() {
        viewController?.displayError()
    }
}

private extension CriptoListPresenter {
    func mapExchangeToViewModel(exchange: ExchangeModel, images: [ExchangeImageModel]) -> CriptoListCellViewModel {
        let imageUrl = images.first(where: { $0.exchangeId == exchange.exchangeId })?.url
        return CriptoListCellViewModel(from: exchange, imageUrl: imageUrl)
    }
}
