import XCTest

final class performance_iosUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    var app: XCUIApplication!
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
    }
    
    override func tearDown() async throws {
        await app.terminate()
        app = nil
    }

    @MainActor
    func testFullStartupTime() throws {
        let options = XCTMeasureOptions()
        options.iterationCount = 3


        measure(
            metrics: [XCTClockMetric()],
            options: options
        ) {
            app.launch()

            let table = app.collectionViews["list-view"].cells.element(boundBy: 0)
            let exists = NSPredicate(format: "exists == true")
            let expectation = XCTNSPredicateExpectation(predicate: exists, object: table)
            let result = XCTWaiter().wait(for: [expectation], timeout: 4)
            XCTAssertEqual(result, .completed, "The table view didn't appear in time.")
        }
    }
}
