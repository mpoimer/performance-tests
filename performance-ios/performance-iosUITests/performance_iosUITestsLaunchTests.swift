import XCTest

final class performance_iosUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testFullStartupTime() throws {
        let options = XCTMeasureOptions()
        options.iterationCount = 100

        let app = XCUIApplication()

        measure(
            metrics: [XCTClockMetric()],
            options: options
        ) {
            app.launch()

            let text = app.staticTexts["test-text"]
            let exists = NSPredicate(format: "exists == true")
            let expectation = XCTNSPredicateExpectation(predicate: exists, object: text)
            let result = XCTWaiter().wait(for: [expectation], timeout: 2)
            XCTAssertEqual(result, .completed, "The text didn't appear in time.")
        }
    }
}
