import SwiftUI

struct MoodLogListView: View {
    var moodLogs: [(mood: String?, date: Date)]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(moodLogs, id: \.date) { log in
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
