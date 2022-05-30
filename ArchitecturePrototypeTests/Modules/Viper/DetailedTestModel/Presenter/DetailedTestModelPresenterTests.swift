//
//  DetailedTestModelPresenterTests.swift
//

import XCTest
@testable import Tonus


class DetailedTestModelPresenterTest: XCTestCase {
    private var interactor: MockInteractor!
    private var router: MockRouter!
    private var view: MockViewController!
    private let context = AnyDetailedTestModelContextMock()

    private var presenter: DetailedTestModelPresenter!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactor = MockInteractor()
        router = MockRouter()
        view = MockViewController()

//         presenter = DetailedTestModelPresenter(
//             interactor: interactor,
//             router: router
//         )
//         presenter.viewInput = view
//         presenter.context = context
    }

    override func tearDown() {
        presenter = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: DetailedTestModelInteractorInputMock {}
    class MockRouter: DetailedTestModelRouterInputMock {}
    class MockViewController: DetailedTestModelViewInputMock {}
}
