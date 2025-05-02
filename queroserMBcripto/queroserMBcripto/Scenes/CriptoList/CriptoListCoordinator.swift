//
//  CriptoListCoordinator.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 02/05/25.
//

import UIKit

final class CriptoListCoordinator {

    // MARK: - Properties
    var navigationController: UINavigationController
    weak var viewController: UIViewController?

    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - ExchangesListCoordinatorProtocol
extension CriptoListCoordinator:CriptoListCoordinatorProtocol {
    func navigateToDetailsScene(exchanges: ExchangeModel, exchangesImage: ExchangeImageModel) {
        debugPrint("Todo")
    }
}
