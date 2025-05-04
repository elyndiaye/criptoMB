//
//  CriptoDetailPresenter.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 02/05/25.
//  
//

import Foundation
import UIKit

class CriptoDetailPresenter {
    // MARK: Properties
   weak var viewController: CriptoDetailViewControllerProtocol?
}

extension CriptoDetailPresenter: CriptoDetailPresenterProtocol {
    func showDataDetail(exchange: ExchangeModel) {
        viewController?.displayDetail(exchange: exchange)
    }
    
    func openUrl(url: URL) {
        UIApplication.shared.open(url)
    }
    
    
}
