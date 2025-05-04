//
//  CriptoDetailInteractorTests.swift
//  queroserMBcriptoTests
//
//  Created by Ely Assumpcao Ndiaye on 03/05/25.
//

import XCTest
@testable import queroserMBcripto

final class CriptoDetailPresenterSpy: CriptoDetailPresenterProtocol {
    var viewController: CriptoDetailViewControllerProtocol?
    
    enum Method: Equatable {
          case showDataDetail(exchange: ExchangeModel)
          case openUrl(url: URL)
      }
      private(set) var calledMethods: [Method] = []

      // MARK: - Public Methods
      func showDataDetail(exchange: ExchangeModel) {
          calledMethods.append(.showDataDetail(exchange: exchange))
      }
      
      func openUrl(url: URL) {
          calledMethods.append(.openUrl(url: url))
      }
    
}

final class CriptoDetailInteractorTests: XCTestCase {

    private var presenterSpy = CriptoDetailPresenterSpy()
    
    let mockExchange = ExchangeModel(name: "Exchange", exchangeId: "exachange_id", website: "http://www.google.com", volume1hrsUsd: 123.9, volume1dayUsd: nil, volume1mthsUsd: nil)

    private lazy var sut = CriptoDetailInteractor(presenter: presenterSpy, exchange: mockExchange)
    
    func testLoadDetail_WhenisCalledSetupDetails_ShouldShowDataDetail() {
            sut.setupDetail()
            XCTAssertEqual(presenterSpy.calledMethods, [.showDataDetail(exchange: mockExchange)])
        }
        
        func testOpenUrl_WhenCalledOpenUrl_ShoulDisplayWebView() {
            sut.openUrl()
            XCTAssertEqual(presenterSpy.calledMethods, [.openUrl(url: URL(string: "http://www.google.com")!)])
        }

}
