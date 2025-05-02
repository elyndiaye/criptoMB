//
//  CriptoListFactory.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 01/05/25.
//

import UIKit

enum CriptoListFactory {
    static func make(navigationController: UINavigationController) -> CriptoListViewController {
        let service: NetworkServiceProtocol = NetworkService()
        let coordinator = CriptoListCoordinator(navigationController: navigationController)
        let presenter = CriptoListPresenter(coordinator: coordinator)
        let interactor = CriptoListInteractor(service: service, presenter: presenter)
        let viewController = CriptoListViewController(interactor: interactor)
        
        presenter.viewController = viewController
        coordinator.viewController = viewController

        return viewController
    }
}
