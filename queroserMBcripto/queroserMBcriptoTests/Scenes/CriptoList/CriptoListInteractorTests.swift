//
//  CriptoListInteractorTests.swift
//  queroserMBcriptoTests
//
//  Created by Ely Assumpcao Ndiaye on 03/05/25.
//

import XCTest
@testable import queroserMBcripto

private final class CriptoListPresernterSpy: CriptoListPresenterProtocol {
    enum Method: Equatable {
        case showExchangeList(exchanges: [ExchangeModel], exchangesIcon: [ExchangeImageModel])
        case showDetails(exchanges: ExchangeModel, exchangesIcon: ExchangeImageModel)
        case showError
    }
    private(set) var calledMethods: [Method] = []
    
    func showExchangeList(exchanges: [ExchangeModel], exchangesIcon: [ExchangeImageModel]) {
        calledMethods.append(.showExchangeList(exchanges: exchanges, exchangesIcon: exchangesIcon))
    }
    
    func showDetails(exchanges: ExchangeModel, exchangesIcon: ExchangeImageModel) {
        calledMethods.append(.showDetails(exchanges: exchanges, exchangesIcon: exchangesIcon))
    }
    
    func showError() {
        calledMethods.append(.showError)
    }
}

private final class NetworkServiceSpy: NetworkServiceProtocol {
           var shouldReturnError = false
           var getExchangeListCalled = false
           var getExchangeImageCalled = false
           
           var exchangeListMock: [ExchangeModel] = []
           var exchangeImageListMock: [ExchangeImageModel] = []
    
    func getExchangeList(completion: @escaping (Result<[ExchangeModel], Error>) -> Void) {
        getExchangeListCalled = true
                   if shouldReturnError {
                       completion(.failure(NSError(domain: "Error", code: -1, userInfo: nil)))
                   } else {
                       completion(.success(exchangeListMock))
                   }
    }
    
    func getExchangeImage(completion: @escaping (Result<[ExchangeImageModel], Error>) -> Void) {
        getExchangeImageCalled = true
                   if shouldReturnError {
                       completion(.failure(NSError(domain: "Error", code: -1, userInfo: nil)))
                   } else {
                       completion(.success(exchangeImageListMock))
                   }
    }
}

final class CriptoListInteractorTests: XCTestCase {

    private var presenterSpy = CriptoListPresernterSpy()
    private let serviceSpy = NetworkServiceSpy()
    
    private lazy var sut = CriptoListInteractor(service: serviceSpy, presenter: presenterSpy)
    
    func testDidTapExchange_WhenCalledShowDetails_ShouldCallShowDetailExchanged() {
        let mockArrayExchangeList =  [ExchangeModel(name: "Exchange", exchangeId: "exchange_id", website: "http://www.google.com", volume1hrsUsd: 123.9, volume1dayUsd: nil, volume1mthsUsd: nil)]
        let mockExchange = ExchangeModel(name: "Exchange", exchangeId: "exchange_id", website: "http://www.google.com", volume1hrsUsd: 123.9, volume1dayUsd: nil, volume1mthsUsd: nil)
        let mockImage = ExchangeImageModel(exchangeId: "exchange_id", url: nil)
        sut.exchangeList = mockArrayExchangeList
        sut.exchangeImages = [ExchangeImageModel(exchangeId: "exchange_id", url: nil)]
        sut.showDetails(indexPath: IndexPath(item: 0, section: 0))
        XCTAssertEqual(presenterSpy.calledMethods, [.showDetails(exchanges: mockExchange, exchangesIcon: mockImage)])
    }
    
    
    func testLoadExchangeListSuccess() {
        sut.loadExchangeList()
                  XCTAssertTrue(self.serviceSpy.getExchangeListCalled)
                  XCTAssertTrue(self.serviceSpy.getExchangeImageCalled)
                  XCTAssertEqual(self.presenterSpy.calledMethods, [.showExchangeList(exchanges: [], exchangesIcon: [])])
    }

}
