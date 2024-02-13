import SwiftUI

struct CalendarDate {
    var date: Date
    var emoji: String
}

struct CalendarGridView: View {
    @Binding var selectedDate: CalendarDate?
    let emojiMap: [String: String]
    
    let loggedEmoji: String
    let loggedDate: Date
    
    var body: some View {
        VStack {
            Text("Calendar")
                .font(.title)
                .padding()
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(monthGrid(), id: \.self) { week in
                    ForEach(week, id: \.self) { day in
                        let emoji = day.date == loggedDate ? loggedEmoji : emojiMap["1"]! // Default emoji if not logged
                        Button(action: {}) {
                            VStack {
                                Text("\(day.day)")
                                Text("\(emoji)")
                            }
                            .padding()
                            .background(selectedDate?.date == day.date ? Color.blue : Color.clear)
                            .clipShape(Circle())
                        }
                    }
                }
            }
            
            Spacer()
        }
        .navigationTitle("Calendar")
    }
    
    // Generate a grid of dates for the current month
    private func monthGrid() -> [[CalendarDay]] {
        let calendar = Calendar.current
        let currentDate = Date()
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let daysInMonth = calendar.range(of: .day, in: .month, for: currentDate)!
        let firstDayOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1))!
        let firstWeekdayOfMonth = calendar.component(.weekday, from: firstDayOfMonth)
        
        var grid = [[CalendarDay]]()
        var week = [CalendarDay]()
        var dayCounter = 1
        
        for day in 1...daysInMonth.count {
            let weekdayIndex = (firstWeekdayOfMonth + day - 2) % 7
            let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth)!
            let calendarDay = CalendarDay(date: date, day: dayCounter)
            week.append(calendarDay)
            dayCounter += 1
            
            if weekdayIndex == 6 || day == daysInMonth.count {
                grid.append(week)
                week = [CalendarDay]()
            }
        }
        
        return grid
    }
}

struct CalendarDay: Hashable {
    var date: Date
    var day: Int
}
