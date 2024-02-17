import SwiftUI

struct LogMoodView: View {
    var selectedDate: Date
    @EnvironmentObject var moodLogData: MoodLogData
    @State private var inputText = ""
    @State private var sentiment = ""
    @State private var isAnalyseMoodClicked = false
    @State private var isShowingMoodLog = false
    @State private var selectedEmoji: String? = nil
    
    var body: some View {
        VStack {
            
            Text("How're you feeling today?")
                .font(.title)
                .padding()
            
            TextField("Write about your day", text: $inputText)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal,20)
            
            
            Button(action: {
                if !inputText.isEmpty {
                    analyzeSentiment()
                    isAnalyseMoodClicked = true
                }
            }) {
                Text("Analyse Mood")
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            if isAnalyseMoodClicked {
                if !sentiment.isEmpty {
                    Text("You feel: \(sentiment)\(selectedEmoji ?? "")")
                        .padding()
                }
               
                Button(action: {
                    isShowingMoodLog = true
                    if let selectedEmoji = selectedEmoji {
                        if let mood = moodLogData.emojiMap.first(where: { $0.value.symbol == selectedEmoji })?.key {
                            moodLogData.moodLogs.append((mood: mood, date: selectedDate))
                            inputText = ""
                            sentiment = ""
                            isAnalyseMoodClicked = false
                        } else {
                            print("Error: Emoji not found in emojiMap for symbol \(selectedEmoji)")
                        }
                    }
                }) {
                    Text("Log Mood")
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .sheet(isPresented: $isShowingMoodLog) {
            MoodLogListView()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func analyzeSentiment() {
        let input = EmosyncClassifierInput(text: self.inputText)
        do {
            let classifier = try EmosyncClassifier(configuration: .init())
            let output = try classifier.prediction(input: input)
            
            if let emojiInfo = moodLogData.emojiMap[output.label] {
                self.selectedEmoji = emojiInfo.symbol
                self.sentiment = emojiInfo.name
            } else {
                self.selectedEmoji = ""
                print("Emoji info not found for index: \(output.label)")
            }
        } catch {
            print("Error loading or predicting sentiment:", error)
            self.sentiment = "Error"
        }
    }
    
}
