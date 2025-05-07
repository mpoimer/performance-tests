import OSLog
import SwiftUI

struct ContentView: View {
    @State var feature = ContentFeature()

    var body: some View {
        NavigationStack {
            Group {
                if feature.testData.isEmpty {
                    ProgressView()
                } else {
                    Text("this is a test")
                        .accessibilityLabel("test-text")
                        .onAppear {
                            os_signpost(.end, log: signpostLog, name: "ElementVisibility", "Prepared UI")
                        }
                    List {
                        ForEach(feature.testData) { item in
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.body)
                                    .fontWeight(.bold)

                                Text(item.bio)
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
            .task {
                await feature.loadTestData()
            }
            .navigationTitle("Test Data \(feature.testData.count)")
        }
    }
}

#Preview {
    ContentView()
}
