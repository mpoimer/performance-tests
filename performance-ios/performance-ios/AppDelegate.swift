import Foundation
import os.signpost
import UIKit

let id = OSSignpostID(log: .default)

let startupLog = OSSignposter(subsystem: "com.example.YourApp", category: ".pointsOfInterest")

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        startupLog.beginInterval("myname", id: id)
        return true
    }
}
