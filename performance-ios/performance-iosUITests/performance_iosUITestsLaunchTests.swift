import XCTest

final class performance_iosUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchToListReadyTime() {
        let options = XCTMeasureOptions()
        options.iterationCount = 1
        let app = XCUIApplication()

        measure(metrics: [
            XCTOSSignpostMetric(
                subsystem: "com.example.YourApp",
                category: ".pointsOfInterest",
                name: "myname"
            ),
        ],
        options: options) {
            app.launch()
        }
    }

    @MainActor
    func testFullStartupTime2() throws {
        let options = XCTMeasureOptions()
        options.iterationCount = 3

        let app = XCUIApplication()

        measure(
            metrics: [XCTClockMetric()],
            options: options
        ) {
            app.launch()

            let table = app.staticTexts["flag-text"]
            let exists = NSPredicate(format: "exists == true")
            let expectation = XCTNSPredicateExpectation(predicate: exists, object: table)

            let waitStart = Date()
            let result = XCTWaiter().wait(for: [expectation], timeout: 4)
            XCTAssertEqual(result, .completed, "The table view didn't appear in time.")
            let elapsed = Date().timeIntervalSince(waitStart)

            print("⏱ Waited: \(elapsed)s for flag-text to appear")
        }
    }

    @MainActor
    func testFullStartupTime() throws {
        let options = XCTMeasureOptions()
        options.iterationCount = 3

        let app = XCUIApplication()

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
