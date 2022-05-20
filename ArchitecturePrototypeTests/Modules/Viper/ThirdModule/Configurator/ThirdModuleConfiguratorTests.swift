//
//  ThirdModuleConfiguratorTests.swift
//

import XCTest
@testable import Tonus

// sourcery:begin: AutoMockable
extension ThirdModuleInteractorInput {}
extension ThirdModuleRouterInput {}
extension ThirdModuleViewInput {}
extension AnyThirdModuleContext {}
// sourcery:end


class ThirdModuleModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {
        var router: ThirdModuleRouterInputMock! = ThirdModuleRouterInputMock()
        var context: AnyThirdModuleContextMock! = AnyThirdModuleContextMock()
        // given
        let (viewController, input) = ThirdModuleConfigurator.configure(
            input: nil,
            context: context,
            router: router

        )
        // then
        XCTAssertNotNil(viewController, "ThirdModuleViewController is nil after configuration")
        XCTAssertNotNil(input, "Module input is nil after configuration")

        guard let presenter: ThirdModulePresenter = viewController.output as? ThirdModulePresenter else {
            XCTAssertTrue(false, "output is not ThirdModulePresenter")
            return
        }

        XCTAssertNotNil(presenter.viewInput, "view in ThirdModulePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in ThirdModulePresenter is nil after configuration")

        XCTAssertNotNil(presenter.context, "context in ThirdModulePresenter is nil after configuration")
        router = nil
        XCTAssertNil(presenter.router, "router in ThirdModulePresenter exist after retain var released")
        context = nil
        XCTAssertNil(presenter.context, "context in ThirdModulePresenter exist after retain var released")

        guard let interactor: ThirdModuleInteractor = presenter.interactor as? ThirdModuleInteractor else {
            XCTAssertTrue(false, "interactor is not ThirdModuleInteractor")
            return
        }

        XCTAssertNotNil(interactor.output, "output in ThirdModuleInteractor is nil after configuration")
    }


    class ThirdModuleViewControllerMock: ThirdModuleViewController {

        var setupDidCall = false

        override func setup() {
            setupDidCall = true
        }
    }
}
