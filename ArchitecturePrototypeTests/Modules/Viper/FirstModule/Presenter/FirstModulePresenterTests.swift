//
//  FirstModulePresenterTests.swift
//

import XCTest
@testable import Tonus


class FirstModulePresenterTest: XCTestCase {
    private var interactor: MockInteractor!
    private var router: MockRouter!
    private var view: MockViewController!
    private let context = AnyFirstModuleContextMock()

    private var presenter: FirstModulePresenter!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactor = MockInteractor()
        router = MockRouter()
        view = MockViewController()

//         presenter = FirstModulePresenter(
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

    class MockInteractor: FirstModuleInteractorInput {}

    class MockRouter: FirstModuleRouterInput {
    }

    class MockViewController: FirstModuleViewInput {
        func setupNodes() {}
        func update(updates: [FirstModuleViewModel.Updates], animated: Bool) {}
    }
}
