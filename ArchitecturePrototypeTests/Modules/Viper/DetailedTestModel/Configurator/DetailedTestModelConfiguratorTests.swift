//
//  DetailedTestModelConfiguratorTests.swift
//

import XCTest
@testable import Tonus

// sourcery:begin: AutoMockable
extension DetailedTestModelInteractorInput {}
extension DetailedTestModelRouterInput {}
extension DetailedTestModelViewInput {}
extension AnyDetailedTestModelContext {}
// sourcery:end


class DetailedTestModelModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {
        var router: DetailedTestModelRouterInputMock! = DetailedTestModelRouterInputMock()
        var context: AnyDetailedTestModelContextMock! = AnyDetailedTestModelContextMock()
        // given
        let (viewController, input) = DetailedTestModelConfigurator.configure(
            input: nil,
            context: context,
            router: router

        )
        // then
        XCTAssertNotNil(viewController, "DetailedTestModelViewController is nil after configuration")
        XCTAssertNotNil(input, "Module input is nil after configuration")

        guard let presenter: DetailedTestModelPresenter = viewController.output as? DetailedTestModelPresenter else {
            XCTAssertTrue(false, "output is not DetailedTestModelPresenter")
            return
        }

        XCTAssertNotNil(presenter.viewInput, "view in DetailedTestModelPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in DetailedTestModelPresenter is nil after configuration")

        XCTAssertNotNil(presenter.context, "context in DetailedTestModelPresenter is nil after configuration")
        router = nil
        XCTAssertNil(presenter.router, "router in DetailedTestModelPresenter exist after retain var released")
        context = nil
        XCTAssertNil(presenter.context, "context in DetailedTestModelPresenter exist after retain var released")

        guard let interactor: DetailedTestModelInteractor = presenter.interactor as? DetailedTestModelInteractor else {
            XCTAssertTrue(false, "interactor is not DetailedTestModelInteractor")
            return
        }

        XCTAssertNotNil(interactor.output, "output in DetailedTestModelInteractor is nil after configuration")
    }


    class DetailedTestModelViewControllerMock: DetailedTestModelViewController {

        var setupDidCall = false

        override func setup() {
            setupDidCall = true
        }
    }
}
