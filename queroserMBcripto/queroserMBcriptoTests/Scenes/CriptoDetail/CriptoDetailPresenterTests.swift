//
//  CriptoDetailPresenterTests.swift
//  queroserMBcriptoTests
//
//  Created by Ely Assumpcao Ndiaye on 03/05/25.
//

import XCTest
@testable import queroserMBcripto

final class CriptoDetailViewControllerSpy: CriptoDetailViewControllerProtocol {
    
    enum Method: Equatable {
            case displayList(exchange: ExchangeModel)
        }
    
        private(set) var calledMethods: [Method] = []
        
        func displayDetail(exchange: ExchangeModel) {
            calledMethods.append(.displayList(exchange: exchange))
        }
}

final class CriptoDetailPresenterTests: XCTestCase {

    private let viewControllerSpy = CriptoDetailViewControllerSpy()
        
    private lazy var sut: CriptoDetailPresenter = {
            let sut = CriptoDetailPresenter()
            sut.viewController = viewControllerSpy
            return sut
        }()
    
    func testPresentDetail_WhenshowDataDetail_ShouldDisplayList() {
        let mockExchange = ExchangeModel(name: "Exchange", exchangeId: "exachange_id", website: "http://www.google.com", volume1hrsUsd: 123.9, volume1dayUsd: nil, volume1mthsUsd: nil)
            sut.showDataDetail(exchange: mockExchange)
            XCTAssertEqual(viewControllerSpy.calledMethods, [.displayList(exchange:mockExchange)])
        }

}
