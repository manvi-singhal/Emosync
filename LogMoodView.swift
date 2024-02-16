import SwiftUI

struct LogMoodView: View {
    var selectedDate: Date
    @EnvironmentObject var moodLogData: MoodLogData
    @State private var inputText = ""
    @State private var sentiment = ""
    @State private var isAnalyseMoodClicked = false
    @State private var isShowingMoodLog = false
    @State private var selectedEmoji: String? = nil
    
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
            
            Button(action: {
                if !inputText.isEmpty {
                    analyzeSentiment()
                    isAnalyseMoodClicked = true
                }
            }) {
                Text("Analyse Mood")
            }
            .padding()
            
            if isAnalyseMoodClicked {
                if !sentiment.isEmpty {
                    Text("You feel: \(sentiment)")
                        .padding()
                    
                    Button(action: {
                        isShowingMoodLog = true
                        if let selectedEmoji = selectedEmoji {
                            let mood = emojiMap.first { $0.value == selectedEmoji }?.key
                            moodLogData.moodLogs.append((mood: mood, date: selectedDate)) // Append to moodLogData directly
                            inputText = ""
                            sentiment = ""
                            isAnalyseMoodClicked = false // Reset the flag
                        }
                    }) {
                        Text("Log Mood")
                    }
                    .padding()
                } else {
                    Text("Sentiment analysis in progress...")
                        .padding()
                }
            }
        }
        .sheet(isPresented: $isShowingMoodLog) {
            MoodLogListView()
        }
    }
    
    func analyzeSentiment() {
        let input = EmosyncClassifierInput(text: self.inputText)
        do {
            let classifier = try EmosyncClassifier(configuration: .init())
            let output = try classifier.prediction(input: input)
            self.sentiment = emojiMap[output.label] ?? "Unknown"
            self.selectedEmoji = self.sentiment.isEmpty ? nil : emojiMap[output.label]
        } catch {
            print("Error loading or predicting sentiment:", error)
            self.sentiment = "Error"
        }
    }
}
