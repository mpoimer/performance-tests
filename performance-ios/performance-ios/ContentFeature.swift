import os.signpost
import SwiftUI

@Observable
class ContentFeature {
    var testData: [TestModel] = []

    func loadTestData() async {
        let url = Bundle.main.url(forResource: "test", withExtension: "json")!
        let decoder = JSONDecoder()
        let model = try! decoder.decode([TestModel].self, from: Data(contentsOf: url))
        testData = model
    }
}
