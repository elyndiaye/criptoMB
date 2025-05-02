//
//  CriptoListInteractor.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 01/05/25.
//  
//

import Foundation

final class CriptoListInteractor{

    private let service: NetworkServiceProtocol
    private let presenter: CriptoListPresenterProtocol
    var exchangeList: [ExchangeModel] = []
    var exchangeImages: [ExchangeImageModel] = []

       init(service: NetworkServiceProtocol, presenter: CriptoListPresenterProtocol) {
           self.service = service
           self.presenter = presenter
       }
   }


extension  CriptoListInteractor: CriptoListInteractorProtocol {
    func loadExchangeList() {
        fetchExchanges {[weak self] in
            guard let self = self else {return}
            self.fetchExchangeImage {
                self.presenter.showExchangeList(exchanges: self.exchangeList, exchangesIcon: self.exchangeImages)
            }
        }
    }
    
    func showDetails(indexPath: IndexPath) {
        let exchange = exchangeList[indexPath.section]
        guard let exchangeId = exchange.exchangeId else {
            print("Error: ID not found")
            return
        }

        let imageModel = exchangeImages.first(where: { $0.exchangeId == exchangeId }) ??
                        ExchangeImageModel(exchangeId: exchange.exchangeId, url: nil)

        presenter.showDetails(exchanges: exchange, exchangesIcon: imageModel)
    }
    
}

private extension CriptoListInteractor {
    func fetchExchanges(completion: @escaping () -> Void) {
        service.getExchangeList { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let fetchedExchanges):
                self.exchangeList = fetchedExchanges
                completion()
            case .failure:
                self.presenter.showError()
            }
        }
    }

    func fetchExchangeImage(completion: @escaping () -> Void) {
        service.getExchangeImage { [weak self] result in
            switch result {
            case .success(let fetchedImages):
                self?.exchangeImages = fetchedImages
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
