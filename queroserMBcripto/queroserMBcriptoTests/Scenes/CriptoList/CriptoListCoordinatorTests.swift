//
//  CriptoListCoordinatorTests.swift
//  queroserMBcriptoTests
//
//  Created by Ely Assumpcao Ndiaye on 03/05/25.
//

import XCTest
@testable import queroserMBcripto

final class CriptoListCoordinatorTests: XCTestCase {

    var coordinator: CriptoListCoordinator!
    
    override func setUp() {
        super.setUp()
        coordinator = CriptoListCoordinator(navigationController: UINavigationController())
    }
    
    func test_WhenNavigate_ShouldDisplayScreen() {
        let mockExchange = ExchangeModel(name: "Exchange", exchangeId: "exachange_id", website: "http://www.google.com", volume1hrsUsd: 123.9, volume1dayUsd: nil, volume1mthsUsd: nil)
        let mockImage = ExchangeImageModel(exchangeId: "exchange_id", url: nil)
        coordinator.navigateToDetailsScene(exchanges: mockExchange, exchangesImage: mockImage)
        
        XCTAssertTrue(coordinator.navigationController.viewControllers.contains { $0 is CriptoDetailViewController })
    }
        
    }


