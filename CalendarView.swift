import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var moodLogData: MoodLogData
    @State var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select a Date", selection: $selectedDate, in: ...Date.now, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                NavigationLink(destination: LogMoodView(selectedDate: selectedDate)) {
                    Text("Log Mood")
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
