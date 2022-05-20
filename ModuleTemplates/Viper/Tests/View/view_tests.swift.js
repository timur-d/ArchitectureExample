<%_ 
fileName = `${moduleName}ViewTests`
-%><%- include("../../fileCommonHeader.ejs"); %>


import XCTest
@testable import <%= productName %>


class <%= moduleName %>ViewTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
