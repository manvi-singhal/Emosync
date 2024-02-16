import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var moodLogData: MoodLogData
    @State private var selectedDate = Date()
    @State private var isDateSelected = false
    
    var body: some View {
        VStack {
            DatePicker("Select a Date", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                .onTapGesture {
                    isDateSelected = true
                }
            
            NavigationLink(destination: LogMoodView(selectedDate: selectedDate), isActive: $isDateSelected) {
                EmptyView()
            }
            .hidden()
        }
        .padding()
    }
}
