<%_ 
fileName = `${moduleName}ConfiguratorTests`
-%><%- include("../../fileCommonHeader.ejs"); %>

import XCTest
@testable import <%= productName %>

// sourcery:begin: AutoMockable
extension <%= moduleName %>InteractorInput {}
extension <%= moduleName %>RouterInput {}
extension <%= moduleName %>ViewInput {}
<%_ if (useCoordinator) { -%>
extension Any<%= moduleName %>Context {}
<%_ } -%>
// sourcery:end


class <%= moduleName %>ModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {
        <%_ if (useCoordinator) { -%>
        var router: <%= moduleName %>RouterInputMock! = <%= moduleName %>RouterInputMock()
        var context: Any<%= moduleName %>ContextMock! = Any<%= moduleName %>ContextMock()
        <%_ } -%>
        // given
        let (viewController, input) = <%= moduleName %>Configurator.configure(
            input: nil<%_ if (useCoordinator) { -%>,
            context: context,
            router: router
            <%_ } %>
        )
        // then
        XCTAssertNotNil(viewController, "<%= moduleName %>ViewController is nil after configuration")
        XCTAssertNotNil(input, "Module input is nil after configuration")

        guard let presenter: <%= moduleName %>Presenter = viewController.output as? <%= moduleName %>Presenter else {
            XCTAssertTrue(false, "output is not <%= moduleName %>Presenter")
            return
        }

        XCTAssertNotNil(presenter.viewInput, "view in <%= moduleName %>Presenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in <%= moduleName %>Presenter is nil after configuration")
        <%_ if (useCoordinator) { %>
        XCTAssertNotNil(presenter.context, "context in <%= moduleName %>Presenter is nil after configuration")
        router = nil
        XCTAssertNil(presenter.router, "router in <%= moduleName %>Presenter exist after retain var released")
        context = nil
        XCTAssertNil(presenter.context, "context in <%= moduleName %>Presenter exist after retain var released")
        <%_ } else { %>
        guard let router: <%= moduleName %>Router = presenter.router as? <%= moduleName %>Router else {
            XCTAssertTrue(false, "router is not <%= moduleName %>Router")
            return
        }

        XCTAssertNotNil(router.viewController, "view in <%= moduleName %>Router is nil after configuration")
        <%_ } %>
        guard let interactor: <%= moduleName %>Interactor = presenter.interactor as? <%= moduleName %>Interactor else {
            XCTAssertTrue(false, "interactor is not <%= moduleName %>Interactor")
            return
        }

        XCTAssertNotNil(interactor.output, "output in <%= moduleName %>Interactor is nil after configuration")
    }


    class <%= moduleName %>ViewControllerMock: <%= moduleName %>ViewController {

        var setupDidCall = false

        override func setup() {
            setupDidCall = true
        }
    }
}
