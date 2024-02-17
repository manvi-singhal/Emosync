import SwiftUI

class MoodLogData: ObservableObject {
    @Published var moodLogs: [(mood: String?, date: Date)] = []
    
    @Published var emojiMap: [String: (symbol: String, name: String)] = [
        "0": ("😢", "Sad"),     // sadness
        "1": ("😄", "Happy"),   // joy
        "2": ("❤️", "Lovely"), // love
        "3": ("😠", "Angry"),   // anger
        "4": ("😨", "Fearful")  // fear
    ]
}
