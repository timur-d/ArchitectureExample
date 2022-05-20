//
//  SecondModuleConfiguratorTests.swift
//

import XCTest
@testable import Tonus

// sourcery:begin: AutoMockable
extension SecondModuleInteractorInput {}
extension SecondModuleRouterInput {}
extension SecondModuleViewInput {}
extension AnySecondModuleContext {}
// sourcery:end


class SecondModuleModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {
        var router: SecondModuleRouterInputMock! = SecondModuleRouterInputMock()
        var context: AnySecondModuleContextMock! = AnySecondModuleContextMock()
        // given
        let (viewController, input) = SecondModuleConfigurator.configure(
            input: nil,
            context: context,
            router: router

        )
        // then
        XCTAssertNotNil(viewController, "SecondModuleViewController is nil after configuration")
        XCTAssertNotNil(input, "Module input is nil after configuration")

        guard let presenter: SecondModulePresenter = viewController.output as? SecondModulePresenter else {
            XCTAssertTrue(false, "output is not SecondModulePresenter")
            return
        }

        XCTAssertNotNil(presenter.viewInput, "view in SecondModulePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SecondModulePresenter is nil after configuration")

        XCTAssertNotNil(presenter.context, "context in SecondModulePresenter is nil after configuration")
        router = nil
        XCTAssertNil(presenter.router, "router in SecondModulePresenter exist after retain var released")
        context = nil
        XCTAssertNil(presenter.context, "context in SecondModulePresenter exist after retain var released")

        guard let interactor: SecondModuleInteractor = presenter.interactor as? SecondModuleInteractor else {
            XCTAssertTrue(false, "interactor is not SecondModuleInteractor")
            return
        }

        XCTAssertNotNil(interactor.output, "output in SecondModuleInteractor is nil after configuration")
    }


    class SecondModuleViewControllerMock: SecondModuleViewController {

        var setupDidCall = false

        override func setup() {
            setupDidCall = true
        }
    }
}
