import SwiftUI

struct MoodLogListView: View {
    @EnvironmentObject var moodLogData: MoodLogData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(moodLogData.moodLogs, id: \.date) { log in
                    if let mood = log.mood, let emojiInfo = moodLogData.emojiMap[mood] {
                        HStack {
                            Text("\(formattedDate(log.date)) - \(emojiInfo.name)\(emojiInfo.symbol)")
                        }
                    } else {
                        Text("\(formattedDate(log.date)) - NA ")
                    }
                }
            }
            .navigationBarTitle("Mood Log")
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
