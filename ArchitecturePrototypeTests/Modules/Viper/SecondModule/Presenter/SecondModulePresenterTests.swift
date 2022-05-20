//
//  SecondModulePresenterTests.swift
//

import XCTest
@testable import Tonus
import SectionDataSource


class SecondModulePresenterTest: XCTestCase {
    private var interactor: MockInteractor!
    private var router: MockRouter!
    private var view: MockViewController!
    private let context = AnySecondModuleContextMock()

    private var presenter: SecondModulePresenter!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactor = MockInteractor()
        router = MockRouter()
        view = MockViewController()

//         presenter = SecondModulePresenter(
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

    class MockInteractor: SecondModuleInteractorInputMock {}
    class MockRouter: SecondModuleRouterInputMock {}
    class MockViewController: SecondModuleViewInputMock {}
}
