import os.signpost
import SwiftUI

@Observable
class ContentFeature {
    var testData: [TestModel] = []

    func loadTestData() async {
        try! await Task.sleep(for: .seconds(3))
        testData = [TestModel(name: "ads", language: "adf", bio: "adf", version: 1.2)]
//        let url = Bundle.main.url(forResource: "test", withExtension: "json")!
//        let decoder = JSONDecoder()
//        let model = try! decoder.decode([TestModel].self, from: Data(contentsOf: url))
//        testData = model
//        os_signpost(.end, log: startupLog, name: "StartupToListReady")
        startupLog.endInterval("myname", .beginState(id: id))
    }
}
