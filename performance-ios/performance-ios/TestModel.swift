import Foundation

struct TestModel: Codable, Identifiable {
    let name: String
    let language: String
    let id: UUID = UUID()
    let bio: String
    let version: Double
}
