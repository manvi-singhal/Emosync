import SwiftUI

struct MoodLogListView: View {
    @EnvironmentObject var moodLogData: MoodLogData // Access moodLogData directly as environment object
    
    var body: some View {
        NavigationView {
            List {
                ForEach(moodLogData.moodLogs, id: \.date) { log in // Access moodLogs from moodLogData
                    if let mood = log.mood {
                        Text("\(mood) - \(formattedDate(log.date))")
                    } else {
                        Text("Mood not selected - \(formattedDate(log.date))")
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
