//
//  CriptoListPresenterTests.swift
//  queroserMBcriptoTests
//
//  Created by Ely Assumpcao Ndiaye on 03/05/25.
//


//CordinatorSpy

private final class CriptoListCoordinatorSpy: CriptoListCoordinatorProtocol {
    
    enum Method: Equatable {
        case navigateToDetailsScene(exchanges: ExchangeModel, exchangesImage: ExchangeImageModel)
    }
    
    private(set) var calledMethods: [Method] = []
    
    func navigateToDetailsScene(exchanges: ExchangeModel, exchangesImage: ExchangeImageModel) {
        calledMethods.append(.navigateToDetailsScene(exchanges: exchanges, exchangesImage: exchangesImage))
    }
    
}


//ViewControllerSpy
private final class CriptoListViewControllerSpy: CriptoListViewControllerProtocol  {

  
    enum Method: Equatable {
        case displayList(exchangeList: [CriptoListCellViewModel])
        case displayError
        case stopLoading
        
        static func == (lhs: CriptoListViewControllerSpy.Method, rhs: CriptoListViewControllerSpy.Method) -> Bool {
            true
        }
    }
    
    private(set) var calledMethods: [Method] = []
    
    func displayList(exchangeList: [CriptoListCellViewModel]) {
        calledMethods.append(.displayList(exchangeList: exchangeList))
    }
    
    func displayError(apiError: ApiError) {
        calledMethods.append(.displayError)
    }
    
    func stopLoading() {
        calledMethods.append(.stopLoading)
    }
    
}

import XCTest
@testable import queroserMBcripto

final class CriptoListPresenterTests: XCTestCase {
    
    private var coordinatorSpy = CriptoListCoordinatorSpy()
    private let viewControllerSpy = CriptoListViewControllerSpy()

    private lazy var sut: CriptoListPresenter = {
        let sut = CriptoListPresenter(coordinator: coordinatorSpy)
        sut.viewController = viewControllerSpy
        return sut
    }()
    
    func testNavigatetoDetail_WhenShowDetails_ShouldNavigateToDetail() {
        let mockExchange = ExchangeModel(name: "Exchange", exchangeId: "exachange_id", website: "http://www.google.com", volume1hrsUsd: 123.9, volume1dayUsd: nil, volume1mthsUsd: nil)
        let mockImage = ExchangeImageModel(exchangeId: "exchange_id", url: nil)
        sut.showDetails(exchanges: mockExchange, exchangesIcon: mockImage)
        XCTAssertEqual(coordinatorSpy.calledMethods,[.navigateToDetailsScene(exchanges: mockExchange, exchangesImage: mockImage)])
    }
    
    func testShowList_WhenSshowExchangeList_ShouldDisplayList() {
        let mockExchange = [ExchangeModel(name: "Exchange", exchangeId: "exachange_id", website: "http://www.google.com", volume1hrsUsd: 123.9, volume1dayUsd: nil, volume1mthsUsd: nil)]
        let mockImage = [ExchangeImageModel(exchangeId: "exchange_id", url: nil)]
        
        let mockCellMoviewModel = [CriptoListCellViewModel(from: ExchangeModel(name: "Exchange", exchangeId: "exachange_id", website: "http://www.google.com", volume1hrsUsd: 123.9, volume1dayUsd: nil, volume1mthsUsd: nil), imageUrl: nil)]
        
        sut.showExchangeList(exchanges: mockExchange, exchangesIcon: mockImage)
        XCTAssertEqual(viewControllerSpy.calledMethods, [.displayList(exchangeList: mockCellMoviewModel)])
    }
    
    func testDisplayErrorWhenShowError_ShouldDisplayError() {
        sut.showError(apiError: .timeout)
        XCTAssertEqual(viewControllerSpy.calledMethods, [.displayError])
    }
    
    
    func testStopLoading_WhenShowError_ShouldStopLoading() {
        sut.showError(apiError: .timeout)
        XCTAssertEqual(viewControllerSpy.calledMethods, [.stopLoading])
    }

}
