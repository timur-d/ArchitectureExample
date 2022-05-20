//
//  ThirdModulePresenterTests.swift
//

import XCTest
@testable import Tonus
import SectionDataSource


class ThirdModulePresenterTest: XCTestCase {
    private var interactor: MockInteractor!
    private var router: MockRouter!
    private var view: MockViewController!
    private let context = AnyThirdModuleContextMock()

    private var presenter: ThirdModulePresenter!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactor = MockInteractor()
        router = MockRouter()
        view = MockViewController()

//         presenter = ThirdModulePresenter(
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

    class MockInteractor: ThirdModuleInteractorInput {}

    class MockRouter: ThirdModuleRouterInput {
    }

    class MockViewController: ThirdModuleViewInput {
        func setupNodes() {}
        func update(updates: [ThirdModuleViewModel.Updates], animated: Bool) {}
        func contentDidUpdate(updates: DataSourceUpdates) {}

        func searchContentDidUpdate(updates: DataSourceUpdates) {}

        func didUpdateSearchState(isSearching: Bool) {}
    }
}
