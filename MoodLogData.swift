import SwiftUI

class MoodLogData: ObservableObject {
    @Published var moodLogs: [(mood: String?, date: Date)] = []
}
