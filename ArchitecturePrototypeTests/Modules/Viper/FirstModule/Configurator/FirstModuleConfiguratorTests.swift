//
//  FirstModuleConfiguratorTests.swift
//

import XCTest
@testable import Tonus

// sourcery:begin: AutoMockable
extension FirstModuleInteractorInput {}
extension FirstModuleRouterInput {}
extension FirstModuleViewInput {}
extension AnyFirstModuleContext {}
// sourcery:end


class FirstModuleModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {
        var router: FirstModuleRouterInputMock! = FirstModuleRouterInputMock()
        var context: AnyFirstModuleContextMock! = AnyFirstModuleContextMock()
        // given
        let (viewController, input) = FirstModuleConfigurator.configure(
            input: nil,
            context: context,
            router: router

        )
        // then
        XCTAssertNotNil(viewController, "FirstModuleViewController is nil after configuration")
        XCTAssertNotNil(input, "Module input is nil after configuration")

        guard let presenter: FirstModulePresenter = viewController.output as? FirstModulePresenter else {
            XCTAssertTrue(false, "output is not FirstModulePresenter")
            return
        }

        XCTAssertNotNil(presenter.viewInput, "view in FirstModulePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in FirstModulePresenter is nil after configuration")

        XCTAssertNotNil(presenter.context, "context in FirstModulePresenter is nil after configuration")
        router = nil
        XCTAssertNil(presenter.router, "router in FirstModulePresenter exist after retain var released")
        context = nil
        XCTAssertNil(presenter.context, "context in FirstModulePresenter exist after retain var released")

        guard let interactor: FirstModuleInteractor = presenter.interactor as? FirstModuleInteractor else {
            XCTAssertTrue(false, "interactor is not FirstModuleInteractor")
            return
        }

        XCTAssertNotNil(interactor.output, "output in FirstModuleInteractor is nil after configuration")
    }


    class FirstModuleViewControllerMock: FirstModuleViewController {

        var setupDidCall = false

        override func setup() {
            setupDidCall = true
        }
    }
}
