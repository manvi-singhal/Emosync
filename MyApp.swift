import SwiftUI

@main
struct MyApp: App {
     @StateObject var moodLogData = MoodLogData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(moodLogData)
        }
    }
}
