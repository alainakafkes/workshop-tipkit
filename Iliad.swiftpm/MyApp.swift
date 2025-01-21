import SwiftUI
import TipKit

@main
struct MyApp: App {
    init() {
        if #available(iOS 17.0, *) {
            try? Tips.configure()
        }
    }

    var body: some Scene {
        WindowGroup {
            if #available(iOS 17.0, *) {
                ContentView()
            } else {
                Text("Please try again on a simulator running iOS 17 or higher!")
            }
        }
    }
}
