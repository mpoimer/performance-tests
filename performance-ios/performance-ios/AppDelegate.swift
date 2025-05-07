import OSLog
import UIKit

let signpostLog = OSLog(subsystem: "at.poimer.performance-ios", category: "UIPerformance")

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        os_signpost(.begin, log: signpostLog, name: "ElementVisibility", "Starting to prepare UI")
        return true
    }
}
