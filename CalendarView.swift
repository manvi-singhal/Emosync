import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            DatePicker("Select a Date", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            
            NavigationLink(destination: LogMoodView(selectedDate: selectedDate)) {
                EmptyView()
            }
            .hidden()
        }
        .padding()
    }
}
