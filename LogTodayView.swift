import SwiftUI

struct LogTodayView: View {
    @State private var inputText = ""
    @State private var sentiment = ""
    @State private var isShowingCalendar = false
    @State private var loggedEmoji = ""
    @State private var loggedDate = Date()
    
    let emojiMap: [String: String] = [
        "0": "😢", // sadness
        "1": "😄", // joy
        "2": "❤️", // love
        "3": "😠", // anger
        "4": "😨"  // fear
    ]
    
    var body: some View {
        VStack {
            Text("Log Your Mood")
                .font(.title)
                .padding()
            
            TextField("Enter text", text: $inputText)
                .padding()
            
            Button(action: analyzeSentiment) {
                Text("Analyze Sentiment")
            }
            .padding()
            
            if !sentiment.isEmpty {
                Text("Sentiment: \(sentiment)")
                    .padding()
            }
            
            Spacer()
            
            Button(action: {
                loggedDate = Date()
                isShowingCalendar = true
            }) {
                Text("Log Mood")
            }
            .padding()
        }
        .sheet(isPresented: $isShowingCalendar) {
            CalendarGridView(selectedDate: .constant(nil), emojiMap: emojiMap, loggedEmoji: loggedEmoji, loggedDate: loggedDate)
        }
    }
    
    func analyzeSentiment() {
        let input = EmosyncClassifierInput(text: self.inputText)
        do {
            let classifier = try EmosyncClassifier(configuration: .init())
            let output = try classifier.prediction(input: input)
            self.sentiment = emojiMap[output.label] ?? "Unknown"
            self.loggedEmoji = self.sentiment
        } catch {
            print("Error loading or predicting sentiment:", error)
            self.sentiment = "Error"
        }
    }
}

