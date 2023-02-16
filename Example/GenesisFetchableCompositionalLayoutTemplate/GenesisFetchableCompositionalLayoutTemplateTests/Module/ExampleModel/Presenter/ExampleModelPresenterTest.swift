//
//  ExampleModelPresenterTest
//  GenesisFetchableCompositionalLayoutTemplate
//
//  Created by Akira Matsuda on 2023/02/14.
//

@testable import GenesisFetchableCompositionalLayoutTemplate
import XCTest

class ExampleModelPresenterTest: XCTestCase {
    class MockInteractor: ExampleModelInteractorInput {
        var sections = [CollectionViewSection]()
    }

    class MockRouter: ExampleModelRouterInput {}

    class MockViewController: ExampleModelViewInput {
        func setupInitialState() {}

        func update(sections: [CollectionViewSection]) {}
    }

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
