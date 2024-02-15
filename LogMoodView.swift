import SwiftUI

struct LogMoodView: View {
    @State private var inputText = ""
    @State private var sentiment = ""
    @State private var isShowingMoodLog = false
    @State private var selectedEmoji: String? = nil
    @State private var loggedDate = Date()
    @State private var moodLogs: [(mood: String?, date: Date)] = [] // Updated array to store mood logs
    
    let emojiMap: [String: String] = [
        "0": "😢", // sadness
        "1": "😄", // joy
        "2": "❤️", // love
        "3": "😠", // anger
        "4": "😨"  // fear
    ]
    
    var body: some View {
        VStack {
            Text("How're you feeling today?")
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
            
            Button(action: {
                isShowingMoodLog = true
                if let selectedEmoji = selectedEmoji {
                    let mood = emojiMap.first { $0.value == selectedEmoji }?.key // Finding the mood corresponding to the selected emoji
                    moodLogs.append((mood: mood, date: loggedDate))
                    // Reset input fields
                    inputText = ""
                    sentiment = ""
                }
            }) {
                Text("Log Mood")
            }
            .padding()
        }
        .sheet(isPresented: $isShowingMoodLog) {
            MoodLogListView(moodLogs: moodLogs)
        }
    }
    
    func analyzeSentiment() {
        let input = EmosyncClassifierInput(text: self.inputText)
        do {
            let classifier = try EmosyncClassifier(configuration: .init())
            let output = try classifier.prediction(input: input)
            self.sentiment = emojiMap[output.label] ?? "Unknown"
            // Set selectedEmoji based on sentiment
            self.selectedEmoji = self.sentiment.isEmpty ? nil : emojiMap[output.label]
        } catch {
            print("Error loading or predicting sentiment:", error)
            self.sentiment = "Error"
        }
    }
}
